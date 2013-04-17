class ViewerController < ApplicationController

  def index
    @podcasts = Podcast.all
  end

  def podcast
    @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
  end

  def episode
    @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
    @episode = Episode.where(:podcast_id => @podcast.id, :episode_number => params[:episode_number]).first
  end

end