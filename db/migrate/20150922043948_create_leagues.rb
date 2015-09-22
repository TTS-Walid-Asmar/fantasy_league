class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.decimal :cost
      t.integer :max_participants
      t.string :status
      t.datetime :start_time

      t.timestamps null: false
    end
  end
end
