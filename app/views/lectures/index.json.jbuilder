json.array!(@lectures) do |lecture|
  json.extract! lecture, :users_id
  json.url lecture_url(lecture, format: :json)
end
