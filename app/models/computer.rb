class Computer < Player
  def difficulty
    raise NotImplementedError
  end

  def move(game)
    column = Strategies::BruteForce.new(game.board, difficulty).best_move('o')
    game.drop(column, 'o')
  end
end
require_dependency 'dumb'
require_dependency 'standard'
require_dependency 'intermediate'
require_dependency 'advanced'
