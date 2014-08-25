require 'erb'
require 'ostruct'
require 'redcarpet'
require 'builder'
require 'require_all'
require_all '.'

desc "Run generator"
task :default do
  Podcast.read("singularity").write("singularity")
end
