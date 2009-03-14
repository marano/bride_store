class Site < ActiveRecord::Base
  
  after_create :create_galeries
  
  belongs_to :we_galery, :class_name => 'Galery'
  belongs_to :showroom_galery, :class_name => 'Galery'
  
  has_attached_file :logo
  has_attached_file :logo_footer
  
  def create_galery
    update_attributes!(:we_galery => Galery.new, :showroom_galery => Galery.new)
  end
  
end
