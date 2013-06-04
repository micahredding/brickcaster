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

  def media_length_formatted
    unless media_length then return 0 end
    Time.at(media_length).utc.strftime("%H:%M:%S") #=> "01:00:00"
  end

end
