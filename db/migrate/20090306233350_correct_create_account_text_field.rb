class CorrectCreateAccountTextField < ActiveRecord::Migration
  def self.up
    rename_column :sites, :create_accout_text, :create_account_text
  end

  def self.down
    rename_column :sites, :create_account_text, :create_accout_text
  end
end
