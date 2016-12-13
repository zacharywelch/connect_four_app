class Intermediate < Computer
  def move(game)
    move_scores = game.board.move_scores_for('o', 2)
    best_move = move_scores.sort_by { |k,v| [v, rand()] }.last[0]
    game.drop(best_move, 'o')
  end  
end