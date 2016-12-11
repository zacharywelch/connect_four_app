class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player_one
      t.string :player_two

      t.timestamps null: false
    end
  end
end
