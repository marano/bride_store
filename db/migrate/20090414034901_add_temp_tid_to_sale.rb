class AddTempTidToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :temp_tid, :string
  end

  def self.down
    remove_column :sales, :temp_tid
  end
end
