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

  create_table "channels", force: :cascade do |t|
    t.string   "ch_id",            limit: 255
    t.string   "name",             limit: 255
    t.integer  "created",          limit: 4
    t.string   "creator",          limit: 255
    t.boolean  "is_archived"
    t.integer  "num_members",      limit: 4
    t.string   "topic_value",      limit: 255
    t.string   "topic_creator",    limit: 255
    t.integer  "topic_last_set",   limit: 4
    t.string   "purpose_value",    limit: 255
    t.string   "purpose_creator",  limit: 255
    t.integer  "purpose_last_set", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "post_type",  limit: 255
    t.string   "user",       limit: 255
    t.text     "text",       limit: 65535
    t.string   "ts",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ts_date"
    t.string   "ch_id",      limit: 255
  end

  create_table "stars", force: :cascade do |t|
    t.string   "post_type",  limit: 255
    t.string   "ts",         limit: 255
    t.string   "user",       limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "starred_by", limit: 255
    t.datetime "ts_date"
    t.string   "ch_id",      limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_id",            limit: 255
    t.string   "name",               limit: 255
    t.boolean  "deleted"
    t.string   "color",              limit: 255
    t.string   "profile_first_name", limit: 255
    t.string   "profile_last_name",  limit: 255
    t.string   "profile_real_name",  limit: 255
    t.string   "profile_email",      limit: 255
    t.string   "profile_skype",      limit: 255
    t.string   "profile_phone",      limit: 255
    t.string   "profile_image_24",   limit: 255
    t.string   "profile_image_32",   limit: 255
    t.string   "profile_image_48",   limit: 255
    t.string   "profile_image_72",   limit: 255
    t.string   "profile_image_192",  limit: 255
    t.boolean  "is_admin"
    t.boolean  "is_owner"
    t.boolean  "has_files"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", force: :cascade do |t|
    t.string   "word",         limit: 255
    t.integer  "count",        limit: 4
    t.boolean  "ignore_flag"
    t.integer  "last_post_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
