class AddAdressToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :adress, :string
  end

  def self.down
    remove_column :lists, :adress
  end
end
