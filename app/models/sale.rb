class Sale < ActiveRecord::Base

  belongs_to :store, :class_name => 'List'
  
  default_scope :order => 'created_at DESC'
  
end
