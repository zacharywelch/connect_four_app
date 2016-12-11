class Move < ActiveRecord::Base
  belongs_to :game

  validates :value, presence: true
  validates :game, presence: true
  validates :row, presence: true, inclusion: { in: 0..5 }
  validates :column, presence: true, inclusion: { in: 0..6 }
end
