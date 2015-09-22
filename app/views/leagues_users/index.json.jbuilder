json.array!(@leagues_users) do |leagues_user|
  json.extract! leagues_user, :id, :league_id, :user_id
  json.url leagues_user_url(leagues_user, format: :json)
end
