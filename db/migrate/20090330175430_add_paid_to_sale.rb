class AddPaidToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :paid, :boolean
  end

  def self.down
    remove_column :sales, :paid
  end
end
