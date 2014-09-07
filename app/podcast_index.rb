class PodcastIndex < Array
  include BrickcasterHelpers

  def podcasts
    @podcasts_loaded ||= self.collect do |podcast_id|
      Podcast.read(podcast_id)
    end
  end

  def write(path)
    write_html_file(path)
    write_podcasts(path)
  end

  def write_html_file(path)
    variables = {
      :podcasts => podcasts,
      :title => "",
      :art_url => nil,
      :podcast_links => false,
      :absolute_url => "http://brickcaster.com"
    }
    output = StaticFile.render("podcast_index.html.erb", self, variables)
    StaticFile.write("#{path}/index.html", output)
  end

  def write_podcasts(path)
    self.podcasts.each do |podcast|
      podcast.write("#{path}/#{podcast.id}")
    end
  end

  def self.read(path)
    self.new ["singularity"]
  end
end
