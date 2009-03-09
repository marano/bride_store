class RemoveProductIdFromGalery < ActiveRecord::Migration
  def self.up
    remove_column :galeries, :product_id
    add_column :products, :galery_id, :integer
  end

  def self.down
    remove_column :products, :galery_id
    add_column :galeries, :product_id, :integer
  end
end
