class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.references :list
      t.references :product
      t.integer :quantity
      t.integer :quantity_bought

      t.timestamps
    end
  end

  def self.down
    drop_table :list_items
  end
end
