class WelcomeController < ApplicationController
  def home
    @user = User.all  
  end

  def upcoming
     @user = User.all  
  end

  def live
     @user = User.all  
  end

  def history
    @user = User.all  
  end

  def contact
  end

  def us
  end

  def help
  end
  
  def balance
    
  end

  def add_to_funds
    current_user.balance += params[:quantity].to_f
    current_user.save
    
    redirect_to root_path
  end
  
   
end
