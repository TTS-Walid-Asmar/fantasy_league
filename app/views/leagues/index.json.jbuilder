json.array!(@leagues) do |league|
  json.extract! league, :id, :name, :cost, :max_participants, :status, :start_time
  json.url league_url(league, format: :json)
end
