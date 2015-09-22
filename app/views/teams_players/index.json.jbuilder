json.array!(@teams_players) do |teams_player|
  json.extract! teams_player, :id
  json.url teams_player_url(teams_player, format: :json)
end
