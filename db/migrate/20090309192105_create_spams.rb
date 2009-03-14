class CreateSpams < ActiveRecord::Migration
  def self.up
    create_table :spams do |t|
      t.string :title
      t.text :body
      t.text :to

      t.timestamps
    end
  end

  def self.down
    drop_table :spams
  end
end
