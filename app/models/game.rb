class Game < ActiveRecord::Base
  belongs_to :blue_player, class_name: 'Player'
  belongs_to :red_player, class_name: 'Player'
  belongs_to :turn, class_name: 'Player'
  has_many :moves, dependent: :destroy

  validates :blue_player, presence: true
  validates :red_player, presence: true

  before_create { self.turn = blue_player }

  def over?
    board.draw? || board.winner?
  end

  def drop(column, disc)
    moves.create(row: next_available_row(column), column: column, value: disc)
  end

  def next_turn
    initialize_board
    unless over?
      toggle_player
      turn.move(self)
    end
  end

  def board
    @board ||= initialize_board
  end

  def next_available_row(column)
    (moves.where(column: column).maximum(:row) || -1) + 1
  end

  def move_at(row, column)
    moves.find { |move| move.row == row && move.column == column }
  end

  private

  def initialize_board
    @board = Board.new
    moves.reload.each { |move| @board.move(move.row, move.column, move.value) }
    @board
  end

  def toggle_player
    update_attributes(turn: turn == blue_player ? red_player : blue_player)
  end
end
