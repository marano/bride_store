class Product < ActiveRecord::Base

  after_create :create_galery
  before_save :update_canonical_name
  
  belongs_to :category
  belongs_to :galery, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :original => ['800x800>', 'jpg'], :big => ['276x276>', 'jpg'], :thumb => ['150x150>', 'jpg'] }
  has_attached_file :display, :styles => { :original => ['780x780>', 'jpg'] }  
  
  #composed_of :price, :class_name => 'Money'
  
  default_scope :order => 'name ASC'
  
  private
  
  def add_list_item(product, quantity)
    
    list_items.create(:product => product, :quantity => quantity)
  end
  
  def list_item_by_product(product)
    list_items.first(:conditions => { :product_id => product.id })
  end
  
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
