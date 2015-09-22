class WelcomeController < ApplicationController
  def home
  end

  def upcoming
  end

  def live
  end

  def history
  end

  def contact
  end

  def us
  end

  def help
  end
  
  def balance
    @user = User.all  
  end

  def add_funds
    
  end
end
