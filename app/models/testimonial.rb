class Testimonial < ActiveRecord::Base
  belongs_to :user
  
  def self.random_featured
    featured_count = count(:conditions => { :featured => true })
    first(:offset => rand(featured_count) , :conditions => { :featured => true })
  end
end
