json.array!(@teams) do |team|
  json.extract! team, :id, :name, :player1, :player2, :player3, :player4, :player5
  json.url team_url(team, format: :json)
end
