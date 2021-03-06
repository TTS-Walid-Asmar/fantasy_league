class AddConfirmedTokenToDevise < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :string
    
    add_column :users, :confirmation_sent_at, :datetime
    
    add_index :users, :confirmation_token, :unique => true
    
    add_column :users, :unconfirmed_email, :string
    
    
    User.update_all(:confirmed_at => Time.now)
    
  end
end
