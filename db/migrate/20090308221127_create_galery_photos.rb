class CreateGaleryPhotos < ActiveRecord::Migration
  def self.up
    create_table :galery_photos do |t|
      t.references :galery

      t.timestamps
    end
  end

  def self.down
    drop_table :galery_photos
  end
end
