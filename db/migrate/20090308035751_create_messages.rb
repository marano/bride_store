class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :body
      t.references :user
      t.references :list

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
