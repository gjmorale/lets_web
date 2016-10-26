class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


  protected

    def logged_in_account
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  	def is_admin
      redirect_to root_url unless current_account.admin?
  	end

    def is_owner? producer
        unless producer.owners.exists?(current_account.id)
        flash[:danger] = "You don't have permission"
        redirect_to root_url 
      end
    end
end
