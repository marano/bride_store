class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.time :time
      t.text :body
      t.boolean :active
      t.boolean :featured
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :testimonials
  end
end
