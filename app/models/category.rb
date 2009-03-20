class Category < ActiveRecord::Base
  
  has_many :products  
  default_scope :order => 'created_at DESC'
  
  def to_s
    name
  end
end
