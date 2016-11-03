class AdminsController < ApplicationController
  before_action :logged_in_account, only: [:create, :destroy]	
  before_action :is_admin, only: [:create, :destroy]	
  before_action :not_self

	def create
		@user = User.find(params[:id])
		if @user.toggle_admin true
			flash[:success] = "User set to admin!"
			redirect_to @user
		else
			flash[:danger] = "User couldn be set to admin"
			render 'users/show'
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.toggle_admin false
			flash[:success] = "User no longer admin!"
			redirect_to @user
		else
			flash[:danger] = "User couldn reset from admin"
			render 'users/show'
		end
	end

	private
		def not_self
			if (@user = User.find(params[:id])) == current_user
				flash[:danger] = "Can't edit your own privileges" 
				redirect_to @user
			end
		end

end
