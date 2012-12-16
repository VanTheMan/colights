class Video
  include Mongoid::Document
  include Mongoid::FullTextSearch
  include Mongoid::Search
  include Sunspot::Mongoid

  field :title, type: String
  field :unique_id, type: String
  field :description, type: String
  field :uploaded_at, type: Date
  field :view_count, type: Integer
  field :thumbnail_uid
  image_accessor :thumbnail

  searchable do
    text :title
    string :title
  end

  belongs_to :match
  belongs_to :movie
  has_many :thumbnails

  fulltext_search_in :title, max_ngrams_to_search: 1000, max_candidate_set_size: 2000
  search_in :title

  def thumb_url
    "http://#{Settings.host}" + thumbnail.url
  end

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(username: YoutubeConfig::USERNAME,
                                          password: YoutubeConfig::PASSWORD,
                                          dev_key: YoutubeConfig::DEV_KEY)
  end

  def self.search_solr(text)
    # binding.pry
    Sunspot.search(Video) do
      keywords text
    end.results
  end

  def self.search(params, movie = nil)
    query = yt_session.videos_by(params)
    results = []

    puts movie.title

    query.videos.each do |video|
      v = save_video(video)
      results << v
      if movie
        movie.videos << v
        movie.save
      end

      video.thumbnails.each do |thumbnail|
        v.thumbnail_url = thumbnail.url if thumbnail.name == "hqdefault"
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