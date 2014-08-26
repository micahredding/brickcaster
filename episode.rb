require 'ostruct'

class Episode < OpenStruct
  include BrickcasterHelpers

  def initialize(args)
    super
  end

  def podcast
    Podcast.read(self.podcast_id)
  end

  def write(path)
    output = StaticFile.render(self, "episode.html.erb", {:episode => self, :podcast => self.podcast})
    StaticFile.write("#{path}/#{episode_number}/index.html", output)
  end

  def self.read(path, episode_number = 1)
    self.new StaticFile.read("#{path}/#{episode_number}.md")
  end
end
