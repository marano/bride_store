class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :canonical_name
      t.text :description
      t.string :code
      t.decimal :price
      t.boolean :featured
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
