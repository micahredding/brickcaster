class Episode < ActiveRecord::Base
  belongs_to :podcast
  attr_accessible :episode_number, :title, :author, :body, :media_url, :podcast_id, :publish_date
  attr_accessor :media_length, :media_title, :media_artist, :media_album, :media_year, :media_track

  after_initialize :load_file_properties_from_database
  after_save :load_file_properties_into_variables

  def list_title
    title
  end

  def media_filesize
    @media_length.to_i || 0
  end

  def load_file_properties_from_database
    tags = attributes
    @media_length = tags['media_length']
    @media_title = tags['media_title']
    @media_artist = tags['media_artist']
    @media_album = tags['media_album']
    @media_year = tags['media_year']
    @media_track = tags['media_track']
  end

  def load_file_properties_into_variables
    if media_url.nil? 
      return nil
    end
    tags = load_file_properties
    @media_length = tags['length']
    @media_title = tags['title']
    @media_artist = tags['artist']
    @media_album = tags['album']
    @media_year = tags['year']
    @media_track = tags['track']
    update_column(:media_length, @media_length)
    update_column(:media_title, @media_title)
    update_column(:media_artist, @media_artist)
    update_column(:media_album, @media_album)
    update_column(:media_year, @media_year)
    update_column(:media_track, @media_track)
  end

  def load_file_properties
    url = URI.parse(media_url) # turn the string into a URI
    http = Net::HTTP.new(url.host, url.port) 
    req = Net::HTTP::Get.new(url.path) # init a request with the url
    # req.range = (0..4096) # limit the load to only 4096 bytes
    res = http.request(req) # load the mp3 file
    child = {} # prepare an empty array to store the metadata we grab
    Mp3Info.open( res.body ) do |m|
      child['length'] = m.length 
      child['title'] = m.tag.title 
      child['artist'] = m.tag.artist
      child['album'] = m.tag.album 
      child['year'] = m.tag.year
      child['track'] = m.tag.track 
    end
    child
  end

end
