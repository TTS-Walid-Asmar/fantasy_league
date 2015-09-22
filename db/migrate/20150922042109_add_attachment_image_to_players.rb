class AddAttachmentImageToPlayers < ActiveRecord::Migration
  def self.up
    change_table :players do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :players, :image
  end
end
