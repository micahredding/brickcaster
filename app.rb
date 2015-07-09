require 'erb'
require 'ostruct'
require 'redcarpet'
require 'builder'
require 'require_all'

class Brickcaster
  def self.read_and_write_podcast
    PodcastIndex.new(["startup", "christiantranshumanist", "singularity", "abstraction"]).write("")
  end
end
