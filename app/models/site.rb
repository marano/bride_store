class Site < ActiveRecord::Base
  
  has_attached_file :logo
  has_attached_file :logo_footer
    
end
