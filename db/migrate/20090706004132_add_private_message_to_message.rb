class AddPrivateMessageToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :private_message, :boolean
  end

  def self.down
    remove_column :messages, :private_message
  end
end
