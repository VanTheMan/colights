class Movie
  include Mongoid::Document

  field :title, type: String
  field :year, type: Integer
  field :gross, type: Integer
  field :studio, type: String

  has_many :videos
end