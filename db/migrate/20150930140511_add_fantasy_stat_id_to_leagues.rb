class AddFantasyStatIdToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :fantasy_stat_id, :integer
  end
end
