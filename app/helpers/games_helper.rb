module GamesHelper
  def cell_for(game, row, column)
    move = game.moves.find { |move| move.row == row && move.column == column }
    if move.present?
      move.value
    else
      '-'
    end
  end
end
