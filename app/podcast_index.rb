class PodcastIndex < Array
  include BrickcasterHelpers

  def podcasts
    @podcasts_loaded ||= self.collect do |podcast_id|
      Podcast.read(podcast_id)
    end
  end

  def write_html_file
    variables = {
      :podcasts      => podcasts,
      :title         => "brickcaster: small podcasts from the human edge",
      :site_name     => "brickcaster: small podcasts from the human edge",
      :description   => "brickcaster: small podcasts from the human edge",
      :art_url       => nil,
      :podcast_links => false,
      :absolute_url  => "http://brickcaster.com"
    }
    output = StaticFile.render("podcast_index.html.erb", self, variables)
    StaticFile.write("/index.html", output)
  end
end
