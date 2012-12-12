class Video
  include Mongoid::Document

  field :title, type: String
  field :unique_id, type: String
  field :description, type: String
  field :uploaded_at, type: Date

  belongs_to :match
end