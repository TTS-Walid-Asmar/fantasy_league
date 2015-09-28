class FantasyStat < ActiveRecord::Base
  include HTTParty
  serialize :fant_stats, Hash
  serialize :player_data, Hash
  serialize :tournaments, Hash
  serialize :players, Array
  serialize :ppg, Hash


  #create new FantasyStat
  #load_tournament_list
  #load_tournament_game_data
  #create_leagues
  #load_player_data
  def load_fantasy_stats
    load_tournament_list
    load_tournament_game_data
    create_leagues
    load_player_data
  end

  base_uri 'http://na.lolesports.com:80/api/'
  def load_tournament_list
    options = {query: {api_key: ENV['riot_games_key'], published: '1' }}
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
    time = self.tournaments[tournament_id]
    response['playerStats'].each do |game, values|
      values['dateTime'] = time
      time += 2.hours
    end
    return response
  end

  def create_leagues
    self.tournaments.each do |tourney, time|
      game_list = create_tourn_game_list(tourney)
      while game_list.count > 0
        league = League.new
        league.tournament_id = tourney
        league.start_time = time
        league.games = game_list.slice!(0..10)
        league.status = "Upcoming"
        league.max_participants = rand(1000)
        league.cost = rand(100)
        league.player_list = create_player_list_and_ppg(tourney, league.games)
        league.name = "Test"
        league.save

      end

    end
    self.save
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
  def create_player_list_and_ppg(tournament_id, games)
    options = {query: {api_key: ENV['riot_games_key']}}
    league_player_list = []
    games.each do |game_id|
      self.fant_stats[tournament_id]['playerStats']["game#{game_id}"].each do |player, value|
        if player.include?('player')
          self.ppg["#{value['playerId']}"] ||= {}
          self.ppg["#{value['playerId']}"]['kills'] ||= 0
          self.ppg["#{value['playerId']}"]['deaths'] ||= 0
          self.ppg["#{value['playerId']}"]['assists'] ||= 0
          self.ppg["#{value['playerId']}"]['minion_kills'] ||= 0
          self.ppg["#{value['playerId']}"]['games'] ||= 0
          self.ppg["#{value['playerId']}"]['kills'] += value['kills'].to_i
          self.ppg["#{value['playerId']}"]['deaths'] += value['deaths'].to_i
          self.ppg["#{value['playerId']}"]['assists'] += value['assists'].to_i
          self.ppg["#{value['playerId']}"]['minion_kills'] += value['minionKills'].to_i
          self.ppg["#{value['playerId']}"]['games'] +=1
          if !league_player_list.include?(value['playerId'].to_i)
            league_player_list.push(value['playerId'].to_i)
          end
          if !self.players.include?(value['playerId'])
            self.players.push(value['playerId'])
          end
        end
      end
    end

    return league_player_list
  end

  def load_player_data
    options = {query: {api_key: ENV['riot_games_key']}}

    self.players.each do |player_id|
      raw_json = self.class.get("/player/#{player_id}.json", options)
      response = raw_json.parsed_response
      self.player_data["#{player_id}"] = response
      self.player_data["#{player_id}"]
    end
    self.save

  end

  def find_player_names(players)
    player_names = []
    players.each do |player_id|
      player_names.push(self.player_data["#{player_id}"]['name'])
    end
    return player_names
  end
  def find_my_player_names(players)
    player_names = []
    players.each do |player_id|
      player_names.push(self.player_data["#{player_id}"]['name'])
    end
    return player_names
  end
  def find_player_roles(players)
    player_roles = []
    players.each do |player_id|
      player_roles.push(find_single_role(player_id))
    end
    return player_roles
  end
  def find_single_role(player_id)
    self.player_data["#{player_id}"]['role']
  end
  def find_player_ppgs(players)
    player_ppgs = []
    players.each do |player_id|
      score = self.ppg["#{player_id}"]['kills']
      score -= self.ppg["#{player_id}"]['deaths']*1.0
      score += self.ppg["#{player_id}"]['assists']*0.5
      score += self.ppg["#{player_id}"]['minion_kills']*0.05
      score = score/self.ppg["#{player_id}"]["games"]
      player_ppgs.push(score.round(1))
    end
    return player_ppgs
  end

  def find_player_costs(player_ppgs)
    total_player_ppgs = 0
    player_ppgs.each do |ppg|
      total_player_ppgs += ppg
    end
    if player_ppgs.size >0
      avg = total_player_ppgs/player_ppgs.size
    end

    costs = []
    player_ppgs.each do |ppg|
      est_cost = (35000/5*ppg/(1.25*(avg + 1))).round(-2)
      costs.push(est_cost)
    end
    return costs
  end
  def find_player_urls(player_ids)
    player_urls = []
    player_ids.each do |player_id|
      player_urls.push(find_single_url(player_id))
    end
    return player_urls
  end
  def find_single_url(player_id)
    self.player_data["#{player_id}"]['photoUrl']
  end
  def find_player_scores(games, player_ids, tournament_id)
    player_scores = {}
    player_ids.each do |player_id|
      player_scores["#{player_id}"] = {}
      player_scores["#{player_id}"]['score']  = 0
    end
    games.each do |game_id|

      if self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]['dateTime'] < Time.now
        player_ids.each do |player_id|

          if self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]["player#{player_id}"]

            kills = self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]["player#{player_id}"]['kills'].to_i
            deaths = self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]["player#{player_id}"]['deaths'].to_i
            assists = self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]["player#{player_id}"]['assists'].to_i
            minion_kills = self.fant_stats["#{tournament_id}"]['playerStats']["game#{game_id}"]["player#{player_id}"]['minionKills'].to_i
            score = kills - deaths + 0.5*assists + 0.05*minion_kills

            player_scores["#{player_id}"]['score']  += score
          end
        end
      end
    end
    return player_scores
  end


  def player_stats(tournament_id, game_id, player_id)
    self.fant_stats[tournament_id]['playerStats']["game#{game_id}"]["player#{player_id}"]
  end

end
