class Thumbnail
  include Mongoid::Document

  field :thumbnail_uid
  image_accessor :thumbnail
  field :name, type: String

  scope :default_img, where(name: "default")
  scope :mq_img, where(name: "mqdefault")
  scope :hq_img, where(name: "hqdefault")

  belongs_to :video

  def self.save_thumbnail(thumbnail)
    t = Thumbnail.create!(name: thumbnail.name)
    t.thumbnail_url = thumbnail.url
    t.save
    t
  end

  def thumb_url
    "http://#{Settings.host}" + thumbnail.url
  end
end