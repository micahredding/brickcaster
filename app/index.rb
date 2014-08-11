class Index < Schema
  def self.get
    super 'data/index.json'
  end
  def podcasts
    @podcasts.collect do |podcast_id|
      Podcast.get(podcast_id)
    end
  end
end
