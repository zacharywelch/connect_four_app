class Game < ActiveRecord::Base
  has_many :moves, dependent: :destroy

  validates :player_one, presence: true
  validates :player_two, presence: true

  before_create { self.turn = player_one }

  def over?
    board.draw? || board.winner?
  end

  def drop(column, disc)
    moves.create(row: next_available_row(column), column: column, value: disc)
  end

  def next_turn
    initialize_board
    toggle_player unless over?
  end

  def board
    @board ||= initialize_board
  end

  def next_available_row(column)
    (moves.where(column: column).maximum(:row) || -1) + 1
  end

  private

  def initialize_board
    @board = Board.new
    moves.reload.each { |move| @board.move(move.row, move.column, move.value) }
    @board
  end

  def toggle_player
    update_attributes(turn: turn == player_one ? player_two : player_one)
  end
end
