class AddDeliveryTextToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :delivery_text, :text
  end

  def self.down
    remove_column :sites, :delivery_text
  end
end
