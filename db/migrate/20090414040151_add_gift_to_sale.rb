class AddGiftToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :gift, :boolean, :default => false
  end

  def self.down
    remove_column :sales, :gift
  end
end
