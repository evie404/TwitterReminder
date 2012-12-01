class RateWatchersController < ApplicationController
  # GET /rate_watchers
  # GET /rate_watchers.json
  def index
    require 'open-uri'
    require 'json'

    url = "https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=yomimaid&count=100"
    @results = JSON.parse(open(url).read)

    @results.each do |result|
      current_user.tweets.where({created_at: Time.parse(result['created_at']), twitter_id: result['id']}).first_or_create
    end

    #logger.debug result[0]

    @rate_watchers = RateWatcher.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rate_watchers }
    end
  end

  # GET /rate_watchers/1
  # GET /rate_watchers/1.json
  def show
    @rate_watcher = RateWatcher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rate_watcher }
    end
  end

  # GET /rate_watchers/new
  # GET /rate_watchers/new.json
  def new
    @rate_watcher = RateWatcher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rate_watcher }
    end
  end

  # GET /rate_watchers/1/edit
  def edit
    @rate_watcher = RateWatcher.find(params[:id])
  end

  # POST /rate_watchers
  # POST /rate_watchers.json
  def create
    @rate_watcher = RateWatcher.new(params[:rate_watcher])

    respond_to do |format|
      if @rate_watcher.save
        format.html { redirect_to @rate_watcher, notice: 'Rate watcher was successfully created.' }
        format.json { render json: @rate_watcher, status: :created, location: @rate_watcher }
      else
        format.html { render action: "new" }
        format.json { render json: @rate_watcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rate_watchers/1
  # PUT /rate_watchers/1.json
  def update
    @rate_watcher = RateWatcher.find(params[:id])

    respond_to do |format|
      if @rate_watcher.update_attributes(params[:rate_watcher])
        format.html { redirect_to @rate_watcher, notice: 'Rate watcher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rate_watcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_watchers/1
  # DELETE /rate_watchers/1.json
  def destroy
    @rate_watcher = RateWatcher.find(params[:id])
    @rate_watcher.destroy

    respond_to do |format|
      format.html { redirect_to rate_watchers_url }
      format.json { head :no_content }
    end
  end
end
