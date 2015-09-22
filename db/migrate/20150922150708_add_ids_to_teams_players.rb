class AddIdsToTeamsPlayers < ActiveRecord::Migration
  def change
    add_column :teams_players, :team_id, :integer
    add_column :teams_players, :player_id, :integer
  end
end
