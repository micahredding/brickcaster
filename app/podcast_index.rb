class PodcastIndex < Array
  include BrickcasterHelpers

  def podcasts
    @podcasts ||= self.collect do |podcast_id|
      Podcast.read(podcast_id)
    end
  end

  def write(path)
    write_html_file(path)
    write_podcasts(path)
  end

  def write_html_file(path)
    output = StaticFile.render("podcast_index.html.erb", self, {:podcasts => podcasts})
    StaticFile.write("#{path}/index.html", output)
  end

  def write_podcasts(path)
    self.podcasts.each do |podcast|
      podcast.write("#{path}/#{podcast}")
    end
  end

  def self.read(path)
    self.new ["singularity"]
  end
end
