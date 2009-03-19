# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090319005548) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_configs", :force => true do |t|
    t.string   "email_adress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galeries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galery_photos", :force => true do |t|
    t.integer  "galery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "list_items", :force => true do |t|
    t.integer  "list_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity_bought", :default => 0
  end

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "text"
    t.string   "nome_noivo"
    t.string   "nome_noivo_pai"
    t.string   "nome_noivo_mae"
    t.string   "nome_noiva"
    t.string   "nome_noiva_pai"
    t.string   "nome_noiva_mae"
    t.string   "nome_outros"
    t.string   "nome_noivo_busca"
    t.string   "nome_noivo_pai_busca"
    t.string   "nome_noivo_mae_busca"
    t.string   "nome_noiva_busca"
    t.string   "nome_noiva_pai_busca"
    t.string   "nome_noiva_mae_busca"
    t.string   "nome_outros_busca"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "galery_id"
    t.string   "adress"
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
  end

  create_table "policies", :force => true do |t|
    t.string   "name"
    t.string   "menu_title"
    t.string   "text_title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "canonical_name"
    t.text     "description"
    t.string   "code"
    t.decimal  "price"
    t.boolean  "featured"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "galery_id"
    t.string   "display_file_name"
    t.string   "display_content_type"
    t.integer  "display_file_size"
    t.datetime "display_updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "home_title"
    t.text     "home_text"
    t.string   "we_title"
    t.text     "we_text"
    t.string   "showroom_title"
    t.text     "showroom_text"
    t.text     "login_text"
    t.text     "search_list_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "footer_text"
    t.text     "create_account_text"
    t.text     "welcome_text"
    t.text     "names_text"
    t.text     "personal_space_text"
    t.text     "empty_list_text"
    t.text     "spam_text"
    t.text     "message_text"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.string   "logo_footer_file_name"
    t.string   "logo_footer_content_type"
    t.integer  "logo_footer_file_size"
    t.integer  "we_galery_id"
    t.integer  "showroom_galery_id"
  end

  create_table "spams", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "list_id"
    t.boolean  "sent"
  end

  create_table "testimonials", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "home_text"
    t.boolean  "active",     :default => false
    t.boolean  "featured",   :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin"
    t.string   "phone"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
