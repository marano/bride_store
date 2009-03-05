class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :home_title
      t.text :home_text
      t.string :we_title
      t.text :we_text
      t.string :showroom_title
      t.text :showroom_text
      t.text :login_text
      t.text :search_list_text

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
