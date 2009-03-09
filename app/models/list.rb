class List < ActiveRecord::Base

  has_many :list_items
  has_many :messages
  belongs_to :user
  before_save :update_nomes_busca
  
  has_attached_file :photo, :styles => { :original => ['512x384>', 'jpg'] }

  def update_nomes_busca
    write_attribute :nome_noivo_busca, nome_noivo.blank? ? '' : nome_noivo.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_noivo_pai_busca, nome_noivo_pai.blank? ? '' : nome_noivo_pai.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_noivo_mae_busca, nome_noivo_mae.blank? ? '' : nome_noivo_mae.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_noiva_busca, nome_noiva.blank? ? '' : nome_noiva.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_noiva_pai_busca, nome_noiva_pai.blank? ? '' : nome_noiva_pai.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_noiva_mae_busca, nome_noiva_mae.blank? ? '' : nome_noiva_mae.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    write_attribute :nome_outros_busca, nome_outros.blank? ? '' : nome_outros.mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end
