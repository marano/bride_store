class AddPhoneAndEmailToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :phone, :string
    add_column :sales, :email, :string
  end

  def self.down
    remove_column :sales, :email
    remove_column :sales, :phone
  end
end
