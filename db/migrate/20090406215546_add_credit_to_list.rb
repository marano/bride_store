class AddCreditToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :credit, :decimal, :default => 0
  end

  def self.down
    remove_column :lists, :credit
  end
end
