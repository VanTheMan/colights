class VideosController < ApplicationController
  def index
    @videos = Video.all.sample(1)
    @top_videos = Video.desc(:view_count).limit(25)
    @recent_videos = Video.all.sample(25)
  end

  def show
    @video = Video.find(params[:id])

  end

  def search
    if params.length == 3
      @movies = Movie.search(params[:q])
      @videos = @movies.each.map{ |m| m.videos }.flatten
    else
      param_search = {
        query: params[:q],
        published: ((Date.today - params[:published].to_i)..(Date.today)),
        duration: params[:duration],
        order_by: params[:order_by]
      }
      @videos = Video.search(param_search)
    end
  end
end