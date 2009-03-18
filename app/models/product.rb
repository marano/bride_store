class Product < ActiveRecord::Base

  after_create :create_galery
  before_save :update_canonical_name
  
  belongs_to :category
  belongs_to :galery, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :original => ['800x800>', 'jpg'], :big => ['300x300>', 'jpg'], :thumb => ['150x150>', 'jpg'] }
  has_attached_file :display, :styles => { :original => ['780x780>', 'jpg'] }  
  
  #composed_of :price, :class_name => 'Money'
  
  private
  
  def update_canonical_name
    write_attribute :canonical_name, name.canonical
  end
  
  def create_galery
    update_attributes!(:galery => Galery.new)
  end
  
  def self.random_featured
    featured_count = count(:conditions => { :featured => true })
    first(:offset => rand(featured_count) , :conditions => { :featured => true })
  end
end
