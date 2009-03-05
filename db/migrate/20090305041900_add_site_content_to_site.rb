class AddSiteContentToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :footer_text, :text
    add_column :sites, :create_accout_text, :text
    add_column :sites, :welcome_text, :text
    add_column :sites, :names_text, :text
    add_column :sites, :personal_space_text, :text
    add_column :sites, :empty_list_text, :text
    add_column :sites, :spam_text, :text
    add_column :sites, :message_text, :text
  end

  def self.down
    remove_column :sites, :message_text
    remove_column :sites, :spam_text
    remove_column :sites, :empty_list_text
    remove_column :sites, :personal_space_text
    remove_column :sites, :names_text
    remove_column :sites, :welcome_text
    remove_column :sites, :create_accout_text
    remove_column :sites, :footer_text
  end
end
