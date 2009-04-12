class RemoveQuantityBoughtFromListItem < ActiveRecord::Migration
  def self.up
    remove_column :list_items, :quantity_bought
  end

  def self.down
    add_column :list_items, :quantity_bought, :integer
  end
end
