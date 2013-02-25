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

ActiveRecord::Schema.define(:version => 20130224195133) do

  create_table "frames", :force => true do |t|
    t.string   "name"
    t.binary   "image"
    t.string   "descr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "pad_id"
  end

  add_index "frames", ["pad_id"], :name => "index_frames_on_pad_id"

  create_table "groups", :force => true do |t|
    t.string   "status"
    t.integer  "num"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "sender"
    t.string   "receiver"
    t.string   "object"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pads", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "project_id"
  end

  add_index "pads", ["project_id"], :name => "index_pads_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
  end

  add_index "projects", ["group_id"], :name => "index_projects_on_group_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "identifier_url"
  end

  add_index "users", ["identifier_url"], :name => "index_users_on_identifier_url", :unique => true

end
