class AddCapturedToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :captured, :boolean, :default => false
  end

  def self.down
    remove_column :sales, :captured
  end
end
