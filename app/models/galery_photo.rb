class GaleryPhoto < ActiveRecord::Base

  belongs_to :galery
  has_attached_file :photo, :styles => { :thumb => ['82x82>','jpg'] }
  
  def url *params
    photo.url *params
  end
end
