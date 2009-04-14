class AddArchivedToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :archived, :boolean, :default => false
  end

  def self.down
    remove_column :lists, :archived
  end
end
