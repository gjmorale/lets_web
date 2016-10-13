class SessionsController < ApplicationController

  def new
  end

  def create
	  account = Account.find_by(email: params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in account
      redirect_to account.user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
end
