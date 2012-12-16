class Movie
  include Mongoid::Document
  include Sunspot::Mongoid

  field :title, type: String
  field :year, type: Integer
  field :gross, type: Integer
  field :studio, type: String

  searchable do
    text :title
    string :title
  end

  def self.search(text)
    # binding.pry
    Sunspot.search(Movie) do
      keywords text
    end.results
  end

  has_many :videos
end