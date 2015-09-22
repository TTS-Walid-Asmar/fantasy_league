json.array!(@players) do |player|
  json.extract! player, :id, :score, :name, :value, :position, :points_per_game
  json.url player_url(player, format: :json)
end
