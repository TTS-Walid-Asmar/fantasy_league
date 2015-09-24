class ChargesController < ApplicationController
  def new
     @amount = params[:amount]
  end

  def create
    # Amount in cents
    @amount = (params[:amount].to_f.round(2) * 100).to_i

    customer = Stripe::Customer.create(
    :email => current_user.email,
    :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
    )
    
    if charge.status == "succeeded"
      current_user.balance += params[:amount].to_f
      current_user.save 
    end 
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    
 
    redirect_to charges_path
    

    
  end

    
  
end
