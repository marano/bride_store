class AddDeliveryToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :delivery, :boolean
  end

  def self.down
    remove_column :sales, :delivery
  end
end
