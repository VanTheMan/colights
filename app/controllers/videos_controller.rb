class VideosController < ApplicationController
  def index
    @videos = Video.all.sample(1)
    @top_videos = Video.desc(:view_count).limit(25)
    @recent_videos = Video.all.sample(25)
    # @action_videos = Movie.genre("Action").map{ |m| m.videos.first }.compact
  end

  def search
    @query = params[:q]
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

  def upload
    client = YouTubeIt::OAuth2Client.new(client_access_token: current_user.access_token,
                                         client_id: YoutubeConfig::CLIENT_ID,
                                         client_secret: YoutubeConfig::CLIENT_SECRET,
                                         dev_key: YoutubeConfig::DEV_KEY)

    client.video_upload(
      File.open(params[:video].tempfile),
      title: params[:title],
      description: params[:description]
    )
    redirect_to root_path
  end

  def view
    @videos = Movie.genre(params["genre"]).map{ |m| m.videos.first }.compact
    @genre = params["genre"]
  end
end