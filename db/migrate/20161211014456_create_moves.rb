class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :row
      t.integer :column
      t.string :value
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
