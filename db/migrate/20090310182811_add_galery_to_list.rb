class AddGaleryToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :galery_id, :integer
  end

  def self.down
    remove_column :lists, :galery_id
  end
end
