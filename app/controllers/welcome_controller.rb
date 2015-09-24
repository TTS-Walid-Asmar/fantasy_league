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
