class CreateFantasyStats < ActiveRecord::Migration
  def change
    create_table :fantasy_stats do |t|
      t.text :fant_stats
    end
  end
end
