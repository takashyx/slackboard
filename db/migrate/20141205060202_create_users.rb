class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :name
      t.boolean :deleted
      t.string :color
      t.string :profile_first_name
      t.string :profile_last_name
      t.string :profile_real_name
      t.string :profile_email
      t.string :profile_skype
      t.string :profile_phone
      t.string :profile_image_24
      t.string :profile_image_32
      t.string :profile_image_48
      t.string :profile_image_72
      t.string :profile_image_192
      t.boolean :is_admin
      t.boolean :is_owner
      t.boolean :has_files

      t.timestamps
    end
  end
end
