require 'ostruct'

class Podcast < OpenStruct
  include BrickcasterHelpers

  def episodes
    episode_numbers.collect do |episode_number|
      Episode.read(podcast_id, episode_number)
    end
  end

  def absolute_url
    "http://brickcaster.com/#{self.podcast_id}"    
  end

  def local_url
    "/#{self.podcast_id}"    
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
    StaticFile.write("#{self.podcast_id}/index.html", output)
  end

  def write_rss_file
    output = StaticFile.render_file("podcast.rss.builder", self, {:podcast => self})
    StaticFile.write("#{self.podcast_id}.rss", output)
  end

  def write_episodes
    self.episodes.each do |episode|
      episode.write
    end
  end

  def self.read(podcast_id)
    args = StaticFile.read("#{podcast_id}/info.md")
    args[:podcast_id] = podcast_id
    self.new args
  end
end
