require 'ostruct'

class Podcast < OpenStruct
  include BrickcasterHelpers

  def initialize(args)
    super
    self.episodes = episodes.collect do |episode_number|
      Episode.read(path, episode_number)
    end
  end

  def write(path)
    write_index_file(path)
    write_rss_file(path)
    write_episodes(path)
  end

  def write_index_file(path)
    output = StaticFile.render(self, "podcast.html.erb", {:podcast => self})
    StaticFile.write("#{path}/index.html", output)
  end

  def write_rss_file(path)
    output = StaticFile.render_file("podcast.rss.builder", self, {:podcast => self})
    StaticFile.write("#{path}.rss", output)
  end

  def write_episodes(path)
    self.episodes.each do |episode|
      episode.write(path)
    end
  end

  def self.read(path)
    args = StaticFile.read("#{path}/info.md")
    args[:path] = path
    self.new args
  end
end
