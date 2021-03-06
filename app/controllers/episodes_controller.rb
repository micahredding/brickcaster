class EpisodesController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show, :index]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes }
    end
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
    if params[:podcast_shortname]
      @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
      unless @podcast
        redirect_to root_path and return
      end
      @episode = Episode.where(:podcast_id => @podcast.id, :episode_number => params[:episode_number]).first
      unless @episode
        redirect_to podcast_show_path and return
      end
    else 
      redirect_to root_path and return      
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @episode }
    end
  end

  # GET /episodes/new
  # GET /episodes/new.json
  def new
    @episode = Episode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @episode }
    end
  end

  # GET /episodes/1/edit
  # GET /podcast_shortname/1/edit
  def edit
    if params[:podcast_shortname]
      @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
      @episode = Episode.where(:podcast_id => @podcast.id, :episode_number => params[:episode_number]).first
    elsif params[:id]
      @episode = Episode.find(params[:id])
      redirect_to episode_edit_path(@episode.podcast.shortname, @episode.episode_number)
    end
  end

  # POST /episodes
  # POST /episodes.json
  def create
    @episode = Episode.new(params[:episode])

    respond_to do |format|
      if @episode.save
        format.html { redirect_to @episode, notice: 'Episode was successfully created.' }
        format.json { render json: @episode, status: :created, location: @episode }
      else
        format.html { render action: "new" }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /episodes/1
  # PUT /episodes/1.json
  def update
    @episode = Episode.find(params[:id])

    respond_to do |format|
      if @episode.update_attributes(params[:episode])
        format.html { redirect_to @episode, notice: 'Episode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy

    respond_to do |format|
      format.html { redirect_to episodes_url }
      format.json { head :no_content }
    end
  end
end
