class CreateLeaguesUsers < ActiveRecord::Migration
  def change
    create_table :leagues_users do |t|
      t.integer :league_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
