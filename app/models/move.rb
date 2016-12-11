class Move < ActiveRecord::Base
  belongs_to :game

  validates :value, presence: true
  validates :game, presence: true
  validates :row, presence: true, 
                  inclusion: { in: 0..5 }, 
                  uniqueness: { scope: [:game, :column] }
  validates :column, presence: true, 
                     inclusion: { in: 0..6 },
                     uniqueness: { scope: [:game, :row] }
  validate :next_available_row, if: :row?, on: :create

  private

  def next_available_row
    unless row == game.next_available_row(column)
      errors.add(:row, "is not available")
    end
  end
end
