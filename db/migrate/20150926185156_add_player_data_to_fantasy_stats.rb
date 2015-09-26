class AddPlayerDataToFantasyStats < ActiveRecord::Migration
  def change
    add_column :fantasy_stats, :player_data, :text
  end
end
