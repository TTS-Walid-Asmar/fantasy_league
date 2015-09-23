class League < ActiveRecord::Base

    has_many :teams
    has_many :leagues_users
    has_many :users, through: :leagues_users

    def upcoming?
      self.status == 'Upcoming'
    end
    def prizes
      total = 0.95*cost*max_participants
    end

end
