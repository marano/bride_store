class AddActiveToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :active, :boolean, :default => true
  end

  def self.down
    remove_column :products, :active
  end
end
