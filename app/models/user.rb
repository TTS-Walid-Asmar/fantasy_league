class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :leagues
  has_many :players
  

  def admin?
    role =="admin"
  end
  
  def guest?
    role =="guest"
  end


end
