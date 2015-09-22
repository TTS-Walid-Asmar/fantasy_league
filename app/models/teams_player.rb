class TeamsPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :team


  def can_add?
    team.players.each do |player1|
      if player1.position == player.position
        return false
      end
      return true
    end
  end

end
