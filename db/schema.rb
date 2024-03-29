# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120606202954) do

  create_table "articles", :force => true do |t|
    t.string   "name",        :default => "Empty name",        :null => false
    t.text     "description", :default => "Empty description", :null => false
    t.text     "fulltext",    :default => "Empty full text",   :null => false
    t.date     "date",        :default => '2001-01-01',        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["date"], :name => "index_articles_on_date"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "mains", :force => true do |t|
    t.string   "title",           :default => "Empty string", :null => false
    t.text     "content",         :default => "Empty string", :null => false
    t.text     "metadescription", :default => "",             :null => false
    t.text     "metakeywords",    :default => "",             :null => false
    t.text     "head",            :default => "",             :null => false
    t.text     "contact",         :default => "",             :null => false
    t.text     "footer",          :default => "",             :null => false
    t.text     "counter",         :default => "",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name",            :default => "Empty string"
    t.string   "title",           :default => "Empty string"
    t.text     "metadescription", :default => ""
    t.text     "metakeywords",    :default => ""
    t.text     "head",            :default => ""
    t.text     "content",         :default => "Empty string"
    t.boolean  "ismenu",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id",        :default => -1,             :null => false
    t.integer  "parent_id",       :default => -1,             :null => false
  end

  add_index "pages", ["id"], :name => "index_pages_on_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                            :default => true
    t.string   "reset_code",         :limit => 40
  end

end
