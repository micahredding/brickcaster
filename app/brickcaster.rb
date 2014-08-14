require 'sinatra'
require 'json'
require 'builder'
require 'yaml'
require 'redcarpet'

helpers BrickcasterHelpers

get '/:podcast_id/:episode_number' do
  @podcast = Podcast.get(params[:podcast_id])
  redirect '/' if @podcast.nil?
	@episode = Episode.get(params[:podcast_id], params[:episode_number])
  redirect '/' if @episode.nil?
	erb :episode
end

get '/:podcast_id.json' do
	@podcast = Podcast.get(params[:podcast_id]);
  redirect '/' if @podcast.nil?
	@podcast.json
end

get '/:podcast_id.rss' do
	@podcast = Podcast.get(params[:podcast_id]);
  redirect '/' if @podcast.nil?
	builder :podcast_rss
end

get '/:podcast_id' do
	@podcast = Podcast.get(params[:podcast_id]);
  redirect '/' if @podcast.nil?
	erb :podcast
end

get '/' do
  @index = Index.get
  erb :index
end
