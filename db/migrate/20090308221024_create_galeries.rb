class CreateGaleries < ActiveRecord::Migration
  def self.up
    create_table :galeries do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :galeries
  end
end
