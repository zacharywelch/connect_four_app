module GamesHelper
  def cell_for(game, row, column)
    move = game.moves.find { |move| move.row == row && move.column == column }
    if move.present?
      content_tag :div, nil, class: move.value == 'x' ? 'disc bg-primary' : 'disc bg-danger'
    elsif game.over?
      content_tag :div, nil, class: 'disc'
    else
      value = @game.turn == @game.blue_player ? 'x' : 'o'
      link_to '', 
              game_moves_path(@game, move: { column: column, value: value }), 
              method: :post,
              class: 'disc'
    end
  end
end
