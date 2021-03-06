class AddAttachmentsLogoFooterToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :logo_footer_file_name, :string
    add_column :sites, :logo_footer_content_type, :string
    add_column :sites, :logo_footer_file_size, :integer
  end

  def self.down
    remove_column :sites, :logo_footer_file_name
    remove_column :sites, :logo_footer_content_type
    remove_column :sites, :logo_footer_file_size
  end
end
