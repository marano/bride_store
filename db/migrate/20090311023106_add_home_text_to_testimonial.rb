class AddHomeTextToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :home_text, :text
  end

  def self.down
    remove_column :testimonials, :home_text
  end
end
