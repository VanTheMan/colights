class Movie
  include Monogoid::Document

  field :title, type: String
  field :year, type: Integer
  field :grosses, type: Integer
  field :content, type: String
  field :rating, type: String

  has_many :videos
end