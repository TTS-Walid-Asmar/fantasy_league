class AddPlayerListToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :player_list, :text
  end
end
