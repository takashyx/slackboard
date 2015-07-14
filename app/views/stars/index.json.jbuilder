json.array!(@stars) do |star|
  json.extract! star, :id, :post_type, :ts, :user, :text, :ts_date, :ch_id
      json.url star_url(star, format: :json)
end
