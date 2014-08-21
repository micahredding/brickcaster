require 'sinatra'
require 'json'
require 'builder'
require 'yaml'
require 'redcarpet'
require 'require_all'
require 'sinatra/export'
require_all 'app'

helpers BrickcasterHelpers

get '/:podcast_id/:episode_number' do
  @podcast = Podcast.get(params[:podcast_id])
	@episode = Episode.get(params[:podcast_id], params[:episode_number])
	erb :episode
end

get '/:podcast_id.json' do
	@podcast = Podcast.get(params[:podcast_id])
	@podcast.json
end

get '/:podcast_id.rss' do
	@podcast = Podcast.get(params[:podcast_id])
	builder :podcast_rss
end

get '/:podcast_id' do
	@podcast = Podcast.get(params[:podcast_id])
	erb :podcast
end

get '/' do
  @index = Index.get
  erb :index
end
