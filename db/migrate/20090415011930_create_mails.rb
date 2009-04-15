class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :mails
  end
end
