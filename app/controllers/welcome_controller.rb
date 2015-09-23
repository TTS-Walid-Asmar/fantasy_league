class WelcomeController < ApplicationController
  def home
    @leagues = League.where(status: "Upcoming")
  end

  def upcoming
     @leagues = current_user.leagues.where(status: "Upcoming")
  end

  def live
     @leagues = current_user.leagues.where(status: "Live")
  end

  def history
    @leagues = current_user.leagues.where(status: "Past")
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
