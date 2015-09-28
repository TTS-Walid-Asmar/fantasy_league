class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
      
      def slug_candidates
      [
        :title,
        [:title, :user_id],
      ]
    end
  
  has_many :teams
  has_many :players
  has_many :leagues_users
  has_many :leagues, through: :leagues_users

  def send_welcome_email
  
    UserMailer.send
  
  end

  def admin?
    role =="admin"
  end

  def guest?
    role =="guest"
  end



  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  def league_score(league)
    team = teams.find_by(league_id: league.id)
    league_score = team.total_score
  end


end
