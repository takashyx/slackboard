json.array!(@words) do |word|
  json.extract! word, :id, :word, :count, :ignore_flag, :last_post_id
  json.url word_url(word, format: :json)
end
