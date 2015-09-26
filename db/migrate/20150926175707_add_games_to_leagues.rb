class AddGamesToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :games, :text
  end
end
