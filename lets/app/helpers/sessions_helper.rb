module SessionsHelper
	# Logs in the given user.
  def log_in(account)
    session[:account_id] = account.id
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_account.nil?
  end

	# Logs in the given user.
  def log_out
    forget @current_account
    session.delete :account_id
    @current_account = nil
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    if logged_in?
    	@current_user ||= @current_account.user
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user.nil? ? false : user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_account
    if (account_id = session[:account_id])
      @current_account ||= Account.find_by(id: account_id)
    elsif (account_id = cookies.signed[:account_id])
      account = Account.find_by(id: account_id)
      if account && account.authenticated?(cookies[:remember_token])
        log_in account
        @current_account = account
      end
    end
  end

  def current_account?(account)
    account.nil? ? false : account == current_account
  end

  # Remembers a user in a persistent session.
  def remember(account)
    account.remember
    cookies.permanent.signed[:account_id] = account.id
    cookies.permanent[:remember_token] = account.remember_token
  end

  # Forgets a persistent session.
  def forget(account)
    account.forget
    cookies.delete(:account_id)
    cookies.delete(:remember_token)
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
