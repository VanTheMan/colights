class Video
  include Mongoid::Document
  include Sunspot::Mongoid

  field :title, type: String
  field :unique_id, type: String
  field :description, type: String
  field :uploaded_at, type: Date
  field :view_count, type: Integer
  field :thumbnail_uid
  image_accessor :thumbnail
  field :genre, type: String

  scope :genre, ->(name) { where(genre: name) }

  searchable do
    text :title
    string :title
  end

  belongs_to :match
  belongs_to :movie
  has_many :thumbnails

  def thumb_url
    thumbnail.nil? ? "http://lorempixel.com/220/124" : thumbnail.thumb('220x124#ne').url
  end

  def youtube_url
    "http://www.youtube.com/watch?v=" + self.unique_id
  end

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(username: YoutubeConfig::USERNAME,
                                          password: YoutubeConfig::PASSWORD,
                                          dev_key: YoutubeConfig::DEV_KEY)
  end

  class << self
    def search_solr(text)
      # binding.pry
      Sunspot.search(Video) do
        keywords text
      end.results
    end

    def search(params, movie = nil)
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

    def save_video(video)
      Video.find_or_create_by(
          title: video.title,
          unique_id: video.unique_id,
          description: video.description,
          uploaded_at: video.uploaded_at,
          view_count: video.view_count
      )
    end
  end
end