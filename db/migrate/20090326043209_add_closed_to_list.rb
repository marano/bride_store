class AddClosedToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :closed, :boolean
  end

  def self.down
    remove_column :lists, :closed
  end
end
