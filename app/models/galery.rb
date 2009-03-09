class Galery < ActiveRecord::Base

  has_many :galery_photos, :dependent => :destroy
  has_one :product
  
end
