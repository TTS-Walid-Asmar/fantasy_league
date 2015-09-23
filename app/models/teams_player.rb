class TeamsPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :team


  def can_add?
    team.players.each do |player1|
      if player1.position.downcase == player.position.downcase
        return false
      end
    end
    return  true
  end

end
