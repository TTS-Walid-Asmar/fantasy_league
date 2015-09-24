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

    # current_user.balance += params[:quantity].to_f
    # current_user.save
    
    @amount = (params[:quantity].to_f.round(2) * 100).to_i
    
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => current_user.id,
      :amount => @amount,
      :description => 'Rails Stripe customer',
      :currency => 'usd'
    )

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
    
    

    redirect_to root_path
  end


end
