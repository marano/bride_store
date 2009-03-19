class AddNameToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :user_name, :string
  end

  def self.down
    remove_column :messages, :user_name
  end
end
