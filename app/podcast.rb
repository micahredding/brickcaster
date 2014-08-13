class Podcast < Schema
  attr_accessor :title, :podcast_id, :author, :url, :itunes_url, :rss_url, :keywords, :categories, :description, :links

  def self.get id
    super 'data/podcasts/' + id + '.json'
  end

  def art_url key="normal"
      @art_url[key]
  end

  def episodes
    @episodes.collect! do |episode_number|
      Episode.get(@podcast_id, episode_number)
    end
  end

  def local_url
    @url.gsub('http://brickcaster.com', '')
  end
end

