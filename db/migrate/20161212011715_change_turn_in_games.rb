class ChangeTurnInGames < ActiveRecord::Migration
  def change
    rename_column :games, :turn, :turn_id
    change_column :games, :turn_id, :integer
  end
end
