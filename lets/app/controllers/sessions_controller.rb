class SessionsController < ApplicationController

  def new
  end

  def create
	  account = Account.find_by(email: params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in account
      params[:session][:remember_me] == '1' ? remember(account) : forget(account)
      redirect_back_or account.user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end

end
