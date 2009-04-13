class Category < ActiveRecord::Base
  
  has_many :products  
  default_scope :order => 'name DESC'
  
  def to_s
    name
  end
end
