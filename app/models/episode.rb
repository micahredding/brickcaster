class Episode < ActiveRecord::Base
  belongs_to :podcast
  attr_accessible :episode_number, :title, :summary, :author, :body, :media_url, :podcast_id, :publish_date
  attr_accessor :media_length, :media_size, :media_title, :media_artist, :media_album, :media_year, :media_track

  after_initialize :load_file_properties_from_database
  after_save :load_file_properties_into_database

  def summary
    if @summary.nil?
      return @body
    else 
      return @summary
  end

  def sort_order
    if episode_number[0,1] == 'p'
      return episode_number[1..-1].to_i - 100
    else
      return episode_number.to_i
    end
  end

  def local_url
    if media_url.nil? || media_url.length == 0 
      return nil
    end    
    'public/brickcaster.resources/' + media_url.split('http://resources.brickcaster.com/')[1]    
  end    

  def media_size
    if @media_size.nil?
      load_file_properties_into_database
      return 0
    end
    @media_size
  end

  def load_file_properties_from_database
    tags = attributes
    @media_length = tags['media_length']
    @media_size = tags['media_size']
    @media_title = tags['media_title']
    @media_artist = tags['media_artist']
    @media_album = tags['media_album']
    @media_year = tags['media_year']
    @media_track = tags['media_track']
  end

  def load_file_properties_into_database
    tags = load_file_properties
    if tags.nil?
      return nil
    end
    @media_length = tags['length']
    @media_size = tags['size']
    @media_title = tags['title']
    @media_artist = tags['artist']
    @media_album = tags['album']
    @media_year = tags['year']
    @media_track = tags['track']
    update_column(:media_length, @media_length)
    update_column(:media_size, @media_size)
    update_column(:media_title, @media_title)
    update_column(:media_artist, @media_artist)
    update_column(:media_album, @media_album)
    update_column(:media_year, @media_year)
    update_column(:media_track, @media_track)
  end

  def load_file_properties
    if ( not local_url ) || ( not File.exist? ( local_url ) )
      return nil
    end
    child = {}    
    child['size'] = File.size( local_url )   
    Mp3Info.open( local_url ) do |m|
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
