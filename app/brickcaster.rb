require 'sinatra'
require 'json'
require 'builder'
require 'redcarpet'

module BrickcasterHelpers
  def markdown
  	@markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:link_attributes => Hash["target" => "_blank"]),
      :hard_wrap => true,
      :autolink => true,
      :space_after_headers => true
    )
  end
  def format_length(length)
    if length.nil?
      return "00:00:00"
    end
    length = Time.at(length.to_i).utc.strftime("%H:%M:%S")
  end
  def format_date(date)
    return 0 if date.nil?
    DateTime.parse(date).rfc822
  end
  def format_date_human(date)
    return 0 if date.nil?
    Date.parse(date).strftime("%Y.%m.%d")
  end
end

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
