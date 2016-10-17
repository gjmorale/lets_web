class UsersController < ApplicationController
	
  def show
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :gender,
  																 :birth_date, :social_id)
  	end
end
