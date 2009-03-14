class AddListIdToSpam < ActiveRecord::Migration
  def self.up
    add_column :spams, :list_id, :integer
  end

  def self.down
    remove_column :spams, :list_id
  end
end
