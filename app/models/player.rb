class Player < ActiveRecord::Base
    has_many :teams_players
    has_many :teams, through: :teams_players

    has_many :leagues
    has_many :users

  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
      
      def slug_candidates
      [
        :name,
        [:name, :id],
      ]
    end
  
end
