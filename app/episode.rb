require 'ostruct'

class Episode < OpenStruct
  include BrickcasterHelpers

  def podcast
    @podcast ||= Podcast.read(self.podcast_id)
  end

  def write(path)
    output = StaticFile.render("episode.html.erb", self, {:episode => self, :podcast => self.podcast, :podcast_links => true})
    StaticFile.write("#{podcast_id}/#{episode_number}/index.html", output)
  end

  def self.read(path, episode_number = 1)
    self.new StaticFile.read("#{path}/#{episode_number}.md")
  end
end
