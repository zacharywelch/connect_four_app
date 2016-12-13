class Player < ActiveRecord::Base
  def move(game)
    fail NotImplementedError
  end
end
