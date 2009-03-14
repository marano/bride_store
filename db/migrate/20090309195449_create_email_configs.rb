class CreateEmailConfigs < ActiveRecord::Migration
  def self.up
    create_table :email_configs do |t|
      t.string :email_adress

      t.timestamps
    end
  end

  def self.down
    drop_table :email_configs
  end
end
