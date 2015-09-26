class AddPlayersToFantasyStats < ActiveRecord::Migration
  def change
    add_column :fantasy_stats, :players, :text
  end
end
