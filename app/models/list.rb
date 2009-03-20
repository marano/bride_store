class List < ActiveRecord::Base

  after_create :create_galery
  before_create :create_adress

  has_many :list_items, :dependent => :destroy
  has_many :spams, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :products, :through => :list_items
  belongs_to :user
  belongs_to :galery, :dependent => :destroy
  before_save :update_nomes_busca
  
  has_attached_file :photo, :styles => { :original => ['512x384>', 'jpg'] }

  def add_list_item(product, quantity)    
    list_item_old = list_item_by_product(product)
    if list_item_old.nil?
      list_items.create(:product => product, :quantity => quantity)
    else
      list_item_old.update_attributes(:quantity => quantity)
    end
  end
  
  def list_item_by_product(product)
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

  private
  
  def create_adress
    write_attribute :adress, name
  end
  
  def create_galery
    update_attributes!(:galery => Galery.new)
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
