class Episode < Schema
  attr_accessor :episode_number, :title, :summary, :author, :url, :media_url, :podcast_id, :publish_date,
  :media_length, :media_size, :media_title, :media_artist, :media_album, :media_year, :media_track

  def self.get podcast_id, episode_number
    super self.filename podcast_id, episode_number
  end

  def self.filename podcast_id, episode_number, format="json"
    'data/episodes/' + podcast_id + '/' + podcast_id + '_' + self.file_number(episode_number) + '.' + format
  end

  def self.meta_filename podcast_id, episode_number
    self.filename(podcast_id, episode_number, 'json')
  end

  def self.body_filename podcast_id, episode_number
    self.filename(podcast_id, episode_number, 'md')
  end

  def self.file_number episode_number
    begin
        "%03d" % Integer(episode_number)
      rescue
        episode_number
      end
  end

  def local_url
    @url.gsub('http://brickcaster.com', '')
  end

  def body
    begin
      markdown.render(File.read(Episode.body_filename(@podcast_id, @episode_number)))
    rescue
      @summary
    end
  end

  def body_truncate
    truncate(body, :length => 255, :separator => "\n")
  end
end
