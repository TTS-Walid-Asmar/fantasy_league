class Player < ActiveRecord::Base
    
    belongs_to :team
    has_many :leagues
    has_many :users
    
    
end
