class CreateTeamsPlayers < ActiveRecord::Migration
  def change
    create_table :teams_players do |t|

      t.timestamps null: false
    end
  end
end
