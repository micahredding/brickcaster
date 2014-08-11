require 'rubygems'
require 'sinatra'
require 'redcarpet'
require 'yaml'
require 'require_all'
require_all 'app'

run Sinatra::Application
