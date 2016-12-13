class Novice < Computer
  def move(game)
    move = Move.new
    until move.persisted?
      move = game.drop(rand(0..6), 'o')
    end
  end
end