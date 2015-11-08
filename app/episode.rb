require 'ostruct'

class Episode < OpenStruct
  include BrickcasterHelpers

  def podcast
    @podcast ||= Podcast.read(self.podcast_id)
  end

  def url
    absolute_url
  end

  def absolute_url
    "http://brickcaster.com/#{podcast_id}/#{episode_number}"
  end    

  def local_url
    "/#{podcast_id}/#{episode_number}"
  end

  def media_track
    episode_number
  end

  def write
    output = StaticFile.render("episode.html.erb", self, {
      :episode       => self,
      :title         => "#{self.title} | #{self.podcast.title}",
      :site_name     => "brickcaster: small podcasts from the human edge",
      :description   => self.summary,
      :podcast       => self.podcast,
      :podcast_links => true,
      :absolute_url  => self.absolute_url,
    })
    StaticFile.write("#{podcast_id}/#{episode_number}/index.html", output)
  end

  def self.read(podcast_id, episode_number)
    args = StaticFile.read("#{podcast_id}/#{episode_number}.md")
    args[:podcast_id] = podcast_id
    args[:episode_number] = episode_number
    self.new args
  end
end
