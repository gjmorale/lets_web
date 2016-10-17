ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:account_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(account)
    session[:account_id] = account.id
  end

  # Log in as a particular user.
  def log_out
    session[:account_id] = nil
  end

end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(account, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: account.email,
                                          password: password,
                                          remember_me: remember_me } }
  end

  # Log out.
  def log_out
    delete logout_path
  end
end
