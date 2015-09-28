class Team < ActiveRecord::Base


    belongs_to :user
    belongs_to :league
    has_many :teams_players
    has_many :players, through: :teams_players
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
      
      def slug_candidates
      [
        :name,
        [:name, :id],
      ]
    end
  
    def total_score
      team_score = 0
      players.each do |player|
        team_score += player.score
      end
      return team_score
    end
end
