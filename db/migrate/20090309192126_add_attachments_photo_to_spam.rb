class AddAttachmentsPhotoToSpam < ActiveRecord::Migration
  def self.up
    add_column :spams, :photo_file_name, :string
    add_column :spams, :photo_content_type, :string
    add_column :spams, :photo_file_size, :integer
    add_column :spams, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :spams, :photo_file_name
    remove_column :spams, :photo_content_type
    remove_column :spams, :photo_file_size
    remove_column :spams, :photo_updated_at
  end
end
