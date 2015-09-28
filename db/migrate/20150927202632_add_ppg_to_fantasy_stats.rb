class AddPpgToFantasyStats < ActiveRecord::Migration
  def change
    add_column :fantasy_stats, :ppg, :text
  end
end
