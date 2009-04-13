class RemoveQuantityChangedFromListItem < ActiveRecord::Migration
  def self.up
    remove_column :list_items, :quantity_changed
  end

  def self.down
    add_column :list_items, :quantity_changed, :integer
  end
end
