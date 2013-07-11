json.array!(@users) do |user|
  json.extract! user, :student, :netid, :email, :first_name, :last_name, :class_year
  json.url user_url(user, format: :json)
end
