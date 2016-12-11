class Game < ActiveRecord::Base
  has_many :moves, dependent: :destroy

  validates :player_one, presence: true
  validates :player_two, presence: true

  def over?
    board.draw? || board.winner?
  end

  def board
    @board ||= initialize_board
  end

  private

  def initialize_board
    @board = Board.new
    moves.reload.each { |move| @board.move(move.row, move.column, move.value) }
    @board
  end
end
