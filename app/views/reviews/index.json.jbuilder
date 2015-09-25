json.array!(@reviews) do |review|
  json.extract! review, :id, :r_title, :r_content
  json.url review_url(review, format: :json)
end
