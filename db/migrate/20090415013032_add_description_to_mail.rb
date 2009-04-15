class AddDescriptionToMail < ActiveRecord::Migration
  def self.up
    add_column :mails, :description, :string
  end

  def self.down
    remove_column :mails, :description
  end
end
