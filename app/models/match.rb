class Match
  include Mongoid::Document

  field :day, type: Date
  field :team_a, type: String
  field :team_b, type: String
  field :score, type: String
  field :tag, type: Array

  has_many :videos

  def self.save_match

  end
end