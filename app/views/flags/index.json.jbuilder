json.array!(@flags) do |flag|
  json.extract! flag, :user_id, :post_id
  json.url flag_url(flag, format: :json)
end
