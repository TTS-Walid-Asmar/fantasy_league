class Team < ActiveRecord::Base

    has_many :teams_players
    belongs_to :user
    belongs_to :league
    has_many :players, through: :teams_players

end
