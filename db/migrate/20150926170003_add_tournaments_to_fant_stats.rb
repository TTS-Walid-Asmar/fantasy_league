class AddTournamentsToFantStats < ActiveRecord::Migration
  def change
    add_column :fantasy_stats, :tournaments, :text
  end
end
