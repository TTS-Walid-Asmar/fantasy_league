class FantasyStat < ActiveRecord::Base
  include HTTParty
  serialize :fant_stats, Hash
  serialize :player_data, Hash
  serialize :tournaments, Hash
  serialize :players, Array
  # base_uri 'https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name'
  base_uri 'http://na.lolesports.com:80/api/'
  def load_tournament_list
    options = {query: {api_key: ENV['riot_games_key'], published: '1%2C0' }}
    response = self.class.get('/tournament.json', options)
    parsed = response.parsed_response
    tournament_ids = {}
    time = Time.now
    parsed.each do |tourney, value|
      tournament_ids[(tourney.gsub('tourney', ''))] = time
      time += 2.days
    end
    self.tournaments = tournament_ids
    self.save
  end
  def load_tournament_game_data
    fant_holder = {}
    self.tournaments.each do |tourney,time|
      fant_holder[tourney] =  load_game_stats(tourney)
    end
    self.fant_stats = fant_holder
    self.save
  end
  def load_game_stats(tournament_id)
    options = {query: {api_key: ENV['riot_games_key'], tournamentId: tournament_id }}
    raw_json = self.class.get('/gameStatsFantasy.json', options)
    response = raw_json.parsed_response
    response['playerStats'].map do |game, values|
      values['dateTime'] = self.tournaments[tournament_id]
    end
    return response
  end

  def create_leagues
    self.tournaments.each do |tourney, time|
      game_list = create_tourn_game_list(tourney)
      while game_list.count > 0
        league = League.new
        league.start_time = time
        league.games = game_list.slice!(0..6)
        league.status = "Upcoming"
        league.max_participants = rand(1000)
        league.cost = rand(100)
        league.player_list = create_player_list(tourney, league.games)
        league.name = "Test"
        league.save
      end

    end
  end
  def create_tourn_game_list(tournament_id)
    game_list = []
    self.fant_stats[tournament_id]['playerStats'].each do |key, value|
      if key.include?('game')
        game_list.push(key.gsub('game', ''))
      end

    end
    return game_list
  end
  def create_player_list(tournament_id, games)
    player_list = []
    games.each do |game_id|
      self.fant_stats[tournament_id]['playerStats']["game#{game_id}"].each do |player, value|
        if player.include?('player')
          if !player_list.include?(value['playerId'])
            player_list.push(value['playerId'])
          end
          if !self.players.include?(value['playerId'])
            self.players.push(value['playerId'])
          end
        end
      end
    end
    return player_list
  end

  def load_player_data
    options = {query: {api_key: ENV['riot_games_key']}}

    self.players.each do |player_id|
      raw_json = self.class.get("/player/#{player_id}.json", options)
      response = raw_json.parsed_response
      self.player_data["#{player_id}"] = response
    end
    self.save

  end

  def find_player_names(players)
    player_names = []
    players.each do |player_id|
      puts player_id
      player_names.push(self.player_data["#{player_id}"]['name'])
    end
    return player_names
  end

  def player_stats(tournament_id, game_id, player_id)
    self.fant_stats[tournament_id]['playerStats']["game#{game_id}"]["player#{player_id}"]
  end

end
