class AddCreditToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :credit, :decimal, :default => 0
  end

  def self.down
    remove_column :sales, :credit
  end
end
