class UsersController < ApplicationController
	
  def show
  	@user = User.find(params[:id])
  end

  def update
  end

  def edit
  end
end
