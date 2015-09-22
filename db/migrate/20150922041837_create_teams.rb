class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :player1
      t.string :player2
      t.string :player3
      t.string :player4
      t.string :player5

      t.timestamps null: false
    end
  end
end
