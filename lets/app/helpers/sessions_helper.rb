module SessionsHelper
	# Logs in the given user.
  def log_in(account)
    session[:account_id] = account.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if logged_in?
    	@current_user ||= current_account.user
    end
  end

  # Returns the current logged-in user (if any).
  def current_account
    @current_account ||= Account.find_by(id: session[:account_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_account.nil?
  end

end
