class AddProductToGalery < ActiveRecord::Migration
  def self.up
    add_column :galeries, :product_id, :integer
  end

  def self.down
    remove_column :galeries, :product_id
  end
end
