class Product < ActiveRecord::Base

  before_create :create_galery
  before_save :update_canonical_name
  
  belongs_to :category
  belongs_to :galery, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :original => ['300x300', 'jpg'], :thumb => ['200x200', 'jpg'] }  
  has_attached_file :display, :styles => { :original => ['780x780', 'jpg'] }  
  
  #composed_of :price, :class_name => 'Money'
  
  private
  
  def update_canonical_name
    write_attribute :canonical_name, name.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
  
  def create_galery
    write_attribute :galery, Galery.new
  end
  
  def self.random_featured
    featured_count = count(:conditions => { :featured => true })
    first(:offset => rand(featured_count) , :conditions => { :featured => true })
  end
end
