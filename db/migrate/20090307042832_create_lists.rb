class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name
      t.string :title
      t.text :text
      t.string :nome_noivo
      t.string :nome_noivo_pai
      t.string :nome_noivo_mae
      t.string :nome_noiva
      t.string :nome_noiva_pai
      t.string :nome_noiva_mae
      t.string :nome_outros
      t.string :nome_noivo_busca
      t.string :nome_noivo_pai_busca
      t.string :nome_noivo_mae_busca
      t.string :nome_noiva_busca
      t.string :nome_noiva_pai_busca
      t.string :nome_noiva_mae_busca
      t.string :nome_outros_busca

      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
