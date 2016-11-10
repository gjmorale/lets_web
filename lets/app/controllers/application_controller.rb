class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProdOwnersHelper


  protected

    def logged_in_account
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  	def is_admin
      unless current_account.admin?
        flash[:danger] = "Requires administrative privileges"
        redirect_to root_url 
      end
  	end

    def account_is_owner? producer
        unless is_owner? producer
        flash[:danger] = "You don't have permission"
        redirect_to root_url 
      end
    end
end
