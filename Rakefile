require 'erb'
require 'ostruct'
require 'redcarpet'
require 'builder'
require 'require_all'
require_all './app'
require_all '.'

desc "Run generator"
task :default do
  Brickcaster.read_and_write_podcast
end
