class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :score
      t.string :name
      t.integer :value
      t.string :position
      t.decimal :points_per_game

      t.timestamps null: false
    end
  end
end
