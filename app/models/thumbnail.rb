class Thumbnail
  include Mongoid::Document

  field :thumbnail_uid
  image_accessor :thumbnail
  field :name, type: String

  belongs_to :video

  def self.save_thumbnail(thumbnail)
    t = Thumbnail.create!(name: thumbnail.name)
    t.thumbnail_url = thumbnail.url
    t.save
    t
  end
end