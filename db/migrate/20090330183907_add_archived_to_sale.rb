class AddArchivedToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :archived, :boolean, :default => false
  end

  def self.down
    remove_column :sales, :archived
  end
end
