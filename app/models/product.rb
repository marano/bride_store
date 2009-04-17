class Product < ActiveRecord::Base

  before_create :fill_galery
  before_save :update_canonical_name
  
  belongs_to :category
  belongs_to :galery, :dependent => :destroy
  
  has_many :list_items
  has_many :sale_items
  
  has_attached_file :photo, :styles => { :original => ['800x800>', 'jpg'], :big => ['276x276>', 'jpg'], :thumb => ['150x150>', 'jpg'] }
  has_attached_file :display, :styles => { :original => ['780x780>', 'jpg'] }  
  
  #composed_of :price, :class_name => 'Money'
  
  default_scope :order => 'name ASC'
  
  def can_delete?
    list_items.empty? and sale_items.empty?
  end
  
  private
  
  def update_canonical_name
    write_attribute :canonical_name, name.canonical
  end
  
  def fill_galery
    self.create_galery
  end
  
  def self.random_featured
    featured_count = count(:conditions => { :featured => true })
    first(:offset => rand(featured_count) , :conditions => { :featured => true })
  end
end
