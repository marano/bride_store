class AddSentToSpam < ActiveRecord::Migration
  def self.up
    add_column :spams, :sent, :boolean
  end

  def self.down
    remove_column :spams, :sent
  end
end
