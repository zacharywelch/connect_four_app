class AddPlayerIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :blue_player_id, :integer
    add_column :games, :red_player_id, :integer
    remove_column :games, :player_one
    remove_column :games, :player_two
  end
end
