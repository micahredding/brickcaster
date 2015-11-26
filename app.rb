require 'erb'
require 'ostruct'
require 'redcarpet'
require 'builder'
require 'require_all'

class Brickcaster
  def self.read_and_write_podcast
    podcast_index = PodcastIndex.new(["christiantranshumanist", "startup", "singularity", "abstraction"])
    podcast_index.write_html_file
    podcast_index.podcasts.each do |podcast|
      podcast.write_html_file
      podcast.write_rss_file
      podcast.episodes.each do |episode|
        episode.write
      end
    end
  end
end
