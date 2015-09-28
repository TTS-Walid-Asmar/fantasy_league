class AddPlayerListToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :player_list, :text
  end
end
