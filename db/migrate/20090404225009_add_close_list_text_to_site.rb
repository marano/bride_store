class AddCloseListTextToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :close_list_text, :text
  end

  def self.down
    remove_column :sites, :close_list_text
  end
end
