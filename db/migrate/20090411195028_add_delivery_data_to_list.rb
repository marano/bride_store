class AddDeliveryDataToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :delivery_date, :date
    add_column :lists, :delivery_adress, :string
  end

  def self.down
    remove_column :lists, :delivery_adress
    remove_column :lists, :delivery_date
  end
end
