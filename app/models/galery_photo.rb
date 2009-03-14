class GaleryPhoto < ActiveRecord::Base

  belongs_to :galery
  has_attached_file :photo, :styles => { :original => ['800x600>', 'jpg'], :thumb => ['82x82>','jpg'] }
  
  def url *params
    photo.url *params
  end
end
