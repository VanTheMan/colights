class VideosController < ApplicationController
  def index
    @videos = Video.all.sample(1)
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @results = Video.fulltext_search(params[:q])
  end
end