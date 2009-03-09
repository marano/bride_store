class RemoveTimeFromTestimonial < ActiveRecord::Migration
  def self.up
    remove_column :testimonials, :time
  end

  def self.down
    add_column :testimonials, :time, :time
  end
end
