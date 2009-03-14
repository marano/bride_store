class AddDefaultsBooleansToTestimonial < ActiveRecord::Migration
  def self.up
    remove_column :testimonials, :active
    add_column :testimonials, :active, :boolean, :default => false
    remove_column :testimonials, :featured
    add_column :testimonials, :featured, :boolean, :default => false
  end

  def self.down
    remove_column :testimonials, :featured
    add_column :testimonials, :featured, :boolean
    remove_column :testimonials, :active
    add_column :testimonials, :active, :boolean, :default => false
  end
end
