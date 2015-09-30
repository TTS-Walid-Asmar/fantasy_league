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
    def money_for_payout
      total = 0.95*self.users.size*self.cost
    end
    def rank_users_by_score
      users.sort{|a, b| b.league_score(self) <=> a.league_score(self)}
    end
    def process_league
      rankings = rank_users_by_score
      winning_score = rankings[((rankings.size-1)/2).to_i].league_score(self)
      winners = rankings.select{|user| user.league_score(self) >= winning_score}
      payout = money_for_payout/(winners.size)

      winners.each do |winner|
        winner.balance += payout
        winner.save
      end
      self.status = "Past"
      self.save
    end
    def is_full?
      self.users.size >= self.max_participants
    end




end
