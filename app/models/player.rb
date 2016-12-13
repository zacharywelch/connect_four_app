class Player < ActiveRecord::Base
  def move(game)
    raise NotImplementedError
  end
end
