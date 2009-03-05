class CreatePolicies < ActiveRecord::Migration
  def self.up
    create_table :policies do |t|
      t.string :name
      t.string :menu_title
      t.string :text_title
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :policies
  end
end
