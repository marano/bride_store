class AddGaleriesToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :we_galery_id, :integer
    add_column :sites, :showroom_galery_id, :integer
  end

  def self.down
    remove_column :sites, :showroom_galery_id
    remove_column :sites, :we_galery_id
  end
end
