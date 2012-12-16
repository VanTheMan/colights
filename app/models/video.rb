class Video
  include Mongoid::Document
  include Mongoid::FullTextSearch
  include Mongoid::Search

  field :title, type: String
  field :unique_id, type: String
  field :description, type: String
  field :uploaded_at, type: Date
  field :view_count, type: Integer

  belongs_to :match
  has_many :thumbnails

  fulltext_search_in :title, max_ngrams_to_search: 1000, max_candidate_set_size: 2000
  search_in :title

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(username: YoutubeConfig::USERNAME,
                                          password: YoutubeConfig::PASSWORD,
                                          dev_key: YoutubeConfig::DEV_KEY)
  end

  def self.search(params, match = nil)
    query = yt_session.videos_by(params)
    results = []
    query.videos.each do |video|
      v = save_video(video)
      results << v
      if match
        match.videos << v
        match.save
      end

      video.thumbnails.each do |thumbnail|
        t = Thumbnail.save_thumbnail(thumbnail)
        v.thumbnails << t
        v.save
      end
    end
    results
  end

  def self.save_video(video)
    Video.find_or_create_by(
        title: video.title,
        unique_id: video.unique_id,
        description: video.description,
        uploaded_at: video.uploaded_at,
        view_count: video.view_count
    )
  end
end