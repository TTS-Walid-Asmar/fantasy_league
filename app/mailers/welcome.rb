class Welcome < ApplicationMailer
    def welcome_email(current_user)
        @user = current_user
        @url = 'https://fant-league.herokuapp.com/'
        mail(to: @user.email, subject: 'Welcome to Fantasy League')
    end 
end
