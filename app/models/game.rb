class Game < ActiveRecord::Base
  has_many :moves

  validates :player_one, presence: true
  validates :player_two, presence: true
end
