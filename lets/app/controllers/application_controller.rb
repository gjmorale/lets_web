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

    def account_is_owner? producer
        unless is_owner? producer
        flash[:danger] = "You don't have permission"
        redirect_to root_url 
      end
    end

    #Duplicated from pro_owners_helper for strage reasons
    def is_owner?(producer)
      producer.nil? ? false : producer.owners.include?(current_account) 
    end
end
