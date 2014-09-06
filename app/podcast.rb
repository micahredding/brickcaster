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
    write_html_file(path)
    write_rss_file(path)
    write_episodes(path)
  end

  def write_html_file(path)
    output = StaticFile.render("podcast.html.erb", self, {:podcast => self, :art_url => self.art_url["wide"], :podcast_links => true})
    StaticFile.write("#{self.podcast_id}/index.html", output)
  end

  def write_rss_file(path)
    output = StaticFile.render_file("podcast.rss.builder", self, {:podcast => self})
    StaticFile.write("#{self.podcast_id}.rss", output)
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
