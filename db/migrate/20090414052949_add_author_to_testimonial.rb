class AddAuthorToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :author, :string
  end

  def self.down
    remove_column :testimonials, :author
  end
end
