class AddTotalsToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_winnings, :decimal
    add_column :users, :total_losses, :decimal
  end
end
