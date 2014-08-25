require 'ostruct'

class Episode < OpenStruct
  include BrickcasterHelpers

  def write(path)
    output = StaticFile.render(self, "episode.html.erb", {:episode => self})
    StaticFile.write("#{path}/#{episode_number}/index.html", output)
  end

  def self.read(path, episode_number = 1)
    self.new StaticFile.read("#{path}/#{episode_number}.md")
  end
end
