class Computer < Player
  def difficulty
    raise NotImplementedError
  end

  def move(game)
    scores = game.board.move_scores_for('o', difficulty)
    best_move = scores.sort_by { |column, score| score }.last[0]
    game.drop(best_move, 'o')
  end
end
require_dependency 'dumb'
require_dependency 'standard'
require_dependency 'intermediate'
require_dependency 'advanced'
