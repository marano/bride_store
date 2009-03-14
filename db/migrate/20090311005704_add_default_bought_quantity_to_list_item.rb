class AddDefaultBoughtQuantityToListItem < ActiveRecord::Migration
  def self.up
    remove_column :list_items, :quantity_bought
    add_column :list_items, :quantity_bought, :integer, :default => 0
  end

  def self.down
    remove_column :list_items, :quantity_bought
    add_column :list_items, :quantity_bought, :integer
  end
end
