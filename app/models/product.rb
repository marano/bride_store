class Product < ActiveRecord::Base
  belongs_to :category
  before_save :update_canonical_name
  
  #composed_of :price, :class_name => 'Money'
  
  private
  
  def update_canonical_name
    write_attribute :canonical_name, name.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end
