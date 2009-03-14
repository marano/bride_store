class Testimonial < ActiveRecord::Base

  before_create :set_home_text
  belongs_to :user
  
  def self.random_featured
    featured_count = count(:conditions => { :featured => true })
    first(:offset => rand(featured_count) , :conditions => { :featured => true })
  end
  
  private
  
  def set_home_text
    if home_text.blank?
      home_text = body
    end
  end
end
