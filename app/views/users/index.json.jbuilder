json.array!(@users) do |user|
  json.extract! user, :nickname, :email, :password
  json.url user_url(user, format: :json)
end