class Team < ActiveRecord::Base


  belongs_to :user
  belongs_to :league
  has_many :teams_players
  has_many :players, through: :teams_players
  serialize :player_list, Array

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
  def total_score
    player_scores = FantasyStat.last.find_player_scores(self.league.games, self.player_list, self.league.tournament_id)
    sum = 0
    player_scores.each do |key, value|
      sum += value['score']
    end
    return sum.round(1)
  end
  def can_add?(player_id)
    roles = FantasyStat.last.find_player_roles(self.player_list)
    player_role = FantasyStat.last.find_single_role(player_id)
    if roles.include?(player_role)
      return false
    end
    return  true
  end
end
