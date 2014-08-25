require 'erb'
require 'ostruct'
require 'redcarpet'
require 'builder'
require 'require_all'

class Brickcaster
  include BrickcasterHelpers

  def read_and_write_podcast
    Podcast.read("singularity").write
  end
end
