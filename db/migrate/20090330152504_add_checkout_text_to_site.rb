class AddCheckoutTextToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :checkout_text, :text
  end

  def self.down
    remove_column :sites, :checkout_text
  end
end
