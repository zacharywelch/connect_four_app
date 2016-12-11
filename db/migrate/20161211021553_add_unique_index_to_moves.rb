class AddUniqueIndexToMoves < ActiveRecord::Migration
  def change
    add_index :moves, [:game_id, :row, :column], unique: true
  end
end
