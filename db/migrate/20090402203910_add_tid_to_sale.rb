class AddTidToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :tid, :string
  end

  def self.down
    remove_column :sales, :tid
  end
end
