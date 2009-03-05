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

ActiveRecord::Schema.define(:version => 20090305175808) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.text     "create_accout_text"
    t.text     "welcome_text"
    t.text     "names_text"
    t.text     "personal_space_text"
    t.text     "empty_list_text"
    t.text     "spam_text"
    t.text     "message_text"
  end

  create_table "testimonials", :force => true do |t|
    t.time     "time"
    t.text     "body"
    t.boolean  "active"
    t.boolean  "featured"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
