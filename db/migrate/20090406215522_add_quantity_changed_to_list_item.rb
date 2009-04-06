class AddQuantityChangedToListItem < ActiveRecord::Migration
  def self.up
    add_column :list_items, :quantity_changed, :integer, :default => 0
  end

  def self.down
    remove_column :list_items, :quantity_changed
  end
end
