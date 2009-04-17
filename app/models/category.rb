class Category < ActiveRecord::Base
  
  has_many :products  
  default_scope :order => 'name DESC'
  
  def can_delete?
    !has_product?
  end
  
  def has_product?
    !products.empty?
  end
  
  def to_s
    name
  end
end
