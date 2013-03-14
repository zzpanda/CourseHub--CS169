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

ActiveRecord::Schema.define(:version => 20130313224449) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "course_semesters", :force => true do |t|
    t.string   "professor"
    t.integer  "course_id",   :null => false
    t.integer  "semester_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "coursems", :force => true do |t|
    t.string   "professor"
    t.integer  "course_id"
    t.integer  "semester_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "coursems_users", :id => false, :force => true do |t|
    t.integer "coursem_id", :null => false
    t.integer "user_id",    :null => false
  end

  add_index "coursems_users", ["coursem_id", "user_id"], :name => "index_coursems_users_on_coursem_id_and_user_id"

  create_table "courses", :force => true do |t|
    t.string   "name",          :null => false
    t.text     "course_info",   :null => false
    t.string   "department",    :null => false
    t.string   "course_number", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "resource_type", :null => false
    t.string   "name",          :null => false
    t.string   "link",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "term",       :null => false
    t.integer  "year",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                  :null => false
    t.string   "email",                     :null => false
    t.string   "password",                  :null => false
    t.integer  "karma",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
