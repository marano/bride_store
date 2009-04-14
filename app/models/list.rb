class List < ActiveRecord::Base

  default_scope :order => 'created_at DESC'

  before_create :fill_galery
  before_create :fill_adress
  before_save :update_nomes_busca

  has_many :list_items, :dependent => :destroy
  has_many :spams, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :products, :through => :list_items
  belongs_to :user
  belongs_to :galery, :dependent => :destroy
  has_many :sales, :foreign_key => 'store_id'
  has_many :sale_items, :through => :sales
  has_many :gift_sales, :class_name => 'Sale', :conditions => { :gift => true }, :foreign_key => 'store_id'
  has_many :gifts, :class_name => 'SaleItem', :through => :gift_sales, :source => :sale_items
  
  has_attached_file :photo, :styles => { :original => ['512x384>', 'jpg'] }
  
  validates_uniqueness_of :adress
  
  def archive!
    update_attributes! :archived => !archived
  end
  
  def has_gift_for_delivery?
    gift_sales.each do |sale|
      return true if sale.has_gift_for_delivery?
    end
    return false
  end
  
  def add_credit(credit_to_sum)
    update_attributes! :credit => credit + credit_to_sum
  end
  
  def total_price
    t = 0
    list_items.each do |list_item|
      t = t + list_item.total_price
    end
    t
  end
  
  def gifts_total_price
    t = 0
    gifts.each do |gift|
      t = t + gift.total_price
    end
    t
  end
  
  def closed?
    closed
  end
  
  def open?
    !closed?
  end

  def add_list_item(product, quantity)    
    list_item_old = find_list_item_by_product(product)
    if list_item_old.nil?
      list_items.create!(:product => product, :quantity => quantity)
    else
      list_item_old.update_attributes!(:quantity => quantity)
    end
  end
  
  def find_list_item_by_product(product)
    list_items.first(:conditions => { :product_id => product.id })
  end

  def categories
    ids = []
    for p in products
      unless ids.include? p.category_id
        ids << p.category_id
      end
    end
    Category.all(:conditions => ['id in (?)', ids])
  end
  
  def to_s
    "#{name} (#{user})"
  end

  private
  
  def fill_adress
    self.adress = name.downcase.trim
  end
  
  def fill_galery
    self.create_galery
  end  

  def update_nomes_busca
    write_attribute :nome_noivo_busca, nome_noivo.blank? ? '' : nome_noivo.canonical
    write_attribute :nome_noivo_pai_busca, nome_noivo_pai.blank? ? '' : nome_noivo_pai.canonical
    write_attribute :nome_noivo_mae_busca, nome_noivo_mae.blank? ? '' : nome_noivo_mae.canonical
    write_attribute :nome_noiva_busca, nome_noiva.blank? ? '' : nome_noiva.canonical
    write_attribute :nome_noiva_pai_busca, nome_noiva_pai.blank? ? '' : nome_noiva_pai.canonical
    write_attribute :nome_noiva_mae_busca, nome_noiva_mae.blank? ? '' : nome_noiva_mae.canonical
    write_attribute :nome_outros_busca, nome_outros.blank? ? '' : nome_outros.canonical
  end
end
