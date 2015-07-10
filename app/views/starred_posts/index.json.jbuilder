json.array!(@starred_posts) do |starred_post|
  json.extract! starred_post, :id, :post_type, :ts, :user, :text
  json.url starred_post_url(starred_post, format: :json)
end
