class AccountsController < ApplicationController
  def new
  	@account = Account.new
  	@user = @account.build_user
  end

  def show
  	@account = Account.find(params[:id])
  end

  def create
  	@account = Account.new(account_params)
    if @account.save
    	log_in @account
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @account.user
    else
      render 'new'
    end
  end

  private
  	def account_params
      params.require(:account).permit(:email, :password,
               :password_confirmation, user_attributes: [:first_name,
               :last_name, :gender, :birth_date, :social_id])
    end
end
