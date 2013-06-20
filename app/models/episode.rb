class Episode < ActiveRecord::Base
  belongs_to :podcast
  attr_accessible :episode_number, :title, :author, :body, :media_url, :podcast_id, :publish_date
  attr_accessor :media_length, :media_title, :media_artist, :media_album, :media_year, :media_track, :media_genre, :media_comment

  after_save :load_media_properties

  def load_media_properties
    # Load a file
    TagLib::FileRef.open(media_url) do |fileref|
      unless fileref.null?
        tag = fileref.tag
        properties = fileref.audio_properties
        @media_length  = properties.length
        @media_title   = tag.title   #=> "Wake Up"
        @media_artist  = tag.artist  #=> "Arcade Fire"
        @media_album   = tag.album   #=> "Funeral"
        @media_year    = tag.year    #=> 2004
        @media_track   = tag.track   #=> 7
        @media_genre   = tag.genre   #=> "Indie Rock"
        @media_comment = tag.comment #=> nil
      end
    end  # File is automatically closed at block end
  end

  def list_title
    title
  end

  def return_media_length
    load_file_properties
    @media_length
  end

  def load_file_properties
    tags = load_file
    @media_title = tags['title']
    @media_album = tags['album']
    @media_artist = tags['artist']
    @media_length = tags['length']
  end

  def load_file
    url = URI.parse(media_url) # turn the string into a URI
    http = Net::HTTP.new(url.host, url.port) 
    req = Net::HTTP::Get.new(url.path) # init a request with the url
    # req.range = (0..4096) # limit the load to only 4096 bytes
    res = http.request(req) # load the mp3 file
    child = [] # prepare an empty array to store the metadata we grab
    Mp3Info.open( StringIO.open(res.body) ) do |m|  #do the parsing
        child['title'] = m.tag.title 
        child['album'] = m.tag.album 
        child['artist'] = m.tag.artist
        child['length'] = m.length 
    end  
    child
  end

  def media_length_formatted
    unless media_length then return 0 end
    Time.at(media_length).utc.strftime("%H:%M:%S") #=> "01:00:00"
  end

end
