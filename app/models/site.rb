class Site < ActiveRecord::Base

  belongs_to :we_galery, :class_name => 'Galery'
  belongs_to :showroom_galery, :class_name => 'Galery'

  has_attached_file :logo
  has_attached_file :logo_footer

  def initialize(*args)
    super(*args)
    if new_record?
      build_we_galery
      build_showroom_galery
      save!
    end
  end
end
