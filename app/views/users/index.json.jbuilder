json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :name, :deleted, :color, :profile_first_name, :profile_last_name, :profile_real_name, :profile_email, :profile_skype, :profile_phone, :profile_image_24, :profile_image_32, :profile_image_48, :profile_image_72, :profile_image_192, :is_admin, :is_owner, :has_files
  json.url user_url(user, format: :json)
end
