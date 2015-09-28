class AddTournamentIdToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :tournament_id, :integer
  end
end
