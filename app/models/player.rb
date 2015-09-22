class Player < ActiveRecord::Base
    has_many :teams_players
    has_many :teams, through: :teams_players

    has_many :leagues
    has_many :users


end
