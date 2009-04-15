class Mail < ActiveRecord::Base

  has_attached_file :image, :styles => { :original => ['320x240>', 'jpg'] }
  
end
