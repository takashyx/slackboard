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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160108221227) do

  create_table "channels", force: true do |t|
    t.string   "ch_id"
    t.string   "name"
    t.integer  "created"
    t.string   "creator"
    t.boolean  "is_archived"
    t.integer  "num_members"
    t.string   "topic_value"
    t.string   "topic_creator"
    t.integer  "topic_last_set"
    t.string   "purpose_value"
    t.string   "purpose_creator"
    t.integer  "purpose_last_set"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loginusers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "loginusers", ["email"], name: "index_loginusers_on_email", unique: true, using: :btree
  add_index "loginusers", ["reset_password_token"], name: "index_loginusers_on_reset_password_token", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.string   "post_type"
    t.string   "user"
    t.text     "text"
    t.string   "ts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ts_date"
    t.string   "ch_id"
  end

  create_table "stars", force: true do |t|
    t.string   "post_type"
    t.string   "ts"
    t.string   "user"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "starred_by"
    t.datetime "ts_date"
    t.string   "ch_id"
  end

  create_table "users", force: true do |t|
    t.string   "user_id"
    t.string   "name"
    t.boolean  "deleted"
    t.string   "color"
    t.string   "profile_first_name"
    t.string   "profile_last_name"
    t.string   "profile_real_name"
    t.string   "profile_email"
    t.string   "profile_skype"
    t.string   "profile_phone"
    t.string   "profile_image_24"
    t.string   "profile_image_32"
    t.string   "profile_image_48"
    t.string   "profile_image_72"
    t.string   "profile_image_192"
    t.boolean  "is_admin"
    t.boolean  "is_owner"
    t.boolean  "has_files"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_counts", force: true do |t|
    t.string   "word"
    t.integer  "count"
    t.boolean  "ignore_flag"
    t.integer  "last_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_ignores", force: true do |t|
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", force: true do |t|
    t.string   "word"
    t.integer  "count"
    t.boolean  "ignore_flag"
    t.integer  "last_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
