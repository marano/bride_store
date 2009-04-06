class AddQuantityChangedToSaleItem < ActiveRecord::Migration
  def self.up
    add_column :sale_items, :quantity_changed, :integer, :default => 0
  end

  def self.down
    remove_column :sale_items, :quantity_changed
  end
end
