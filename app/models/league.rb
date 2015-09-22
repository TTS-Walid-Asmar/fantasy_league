class League < ActiveRecord::Base

    has_many :teams
    has_many :leagues_users
    has_many :users, through: :leagues_users

    def upcoming?
      self.status == 'Upcoming'
    end

end
