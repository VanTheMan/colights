class Movie
  include Mongoid::Document
  include Sunspot::Mongoid

  field :title, type: String
  field :year, type: Integer
  field :gross, type: Integer
  field :studio, type: String

  has_many :videos

  searchable do
    text :title
    string :title
  end

  def self.search(text)
    Sunspot.search(Movie) do
      keywords text
    end.results
  end

  def crawled
    self.videos.count > 0
  end
end