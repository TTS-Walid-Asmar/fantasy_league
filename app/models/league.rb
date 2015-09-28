class League < ActiveRecord::Base

    has_many :teams
    has_many :leagues_users
    has_many :users, through: :leagues_users
    serialize :games, Array
    serialize :player_list, Array
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
      
      def slug_candidates
      [
        :name,
        [:name, :id],
      ]
    end
  
    def upcoming?
      self.status == 'Upcoming'
    end
    def prizes
      total = 0.95*cost*max_participants
    end
    def rank_users_by_score
      users.sort{|a, b| b.league_score(self) <=> a.league_score(self)}
    end


end
