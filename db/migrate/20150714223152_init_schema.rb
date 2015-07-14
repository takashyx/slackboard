class InitSchema < ActiveRecord::Migration
  def up
    
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
    
    create_table "posts", force: true do |t|
      t.string   "post_type"
      t.string   "user"
      t.text     "text"
      t.string   "ts"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "ts_date"
      t.string   "channel_id"
    end
    
    create_table "starred_posts", force: true do |t|
      t.string   "post_type"
      t.string   "ts"
      t.string   "user"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "starred_by"
      t.datetime "ts_date"
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
    
  end

  def down
    raise "Can not revert initial migration"
  end
end
