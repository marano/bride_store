class RemoveDeliveryFromSale < ActiveRecord::Migration
  def self.up
    remove_column :sales, :delivery
  end

  def self.down
    add_column :sales, :delivery, :boolean
  end
end
