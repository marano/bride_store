class AddDeliveryToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :delivery, :boolean
  end

  def self.down
    remove_column :lists, :delivery
  end
end
