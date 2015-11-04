require 'ostruct'

class Podcast < OpenStruct
  include BrickcasterHelpers

  def initialize(args)
    super
    self.episodes = episodes.collect do |episode_number|
      Episode.read(path, episode_number)
    end
  end

  def absolute_url
    "http://brickcaster.com/#{self.podcast_id}"    
  end

  def local_url_index
    "#{self.podcast_id}/index.html"
  end

  def local_url_rss
    "#{self.podcast_id}.rss"
  end

  def write
    write_html_file
    write_rss_file
    write_episodes
  end

  def write_html_file
    output = StaticFile.render("podcast.html.erb", self, {
      :podcast       => self,
      :title         => self.title,
      :site_name     => "brickcaster: small podcasts from the human edge",  
      :description   => self.description,    
      :art_url       => self.art_url["wide"],
      :podcast_links => true,
      :absolute_url  => self.absolute_url
    })
    StaticFile.write(self.local_url_index, output)
  end

  def write_rss_file
    output = StaticFile.render_file("podcast.rss.builder", self, {:podcast => self})
    StaticFile.write(self.local_url_rss, output)
  end

  def write_episodes
    self.episodes.each do |episode|
      episode.write
    end
  end

  def self.read(path)
    args = StaticFile.read("#{path}/info.md")
    args[:path] = path
    self.new args
  end
end
