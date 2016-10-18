class AccountsController < ApplicationController
  before_action :logged_in_account, only: [:destroy, :edit, :update]
  before_action :is_admin, only: [:destroy]

  def new
  	@account = Account.new
  	@user = @account.build_user
  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
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

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "Account updated"
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    Account.find(params[:id]).destroy
    flash[:success] = "Account deleted"
    redirect_to users_url
  end

  private
  	def account_params
      params.require(:account).permit(:email, :password,
               :password_confirmation, user_attributes: [:first_name,
               :last_name, :gender, :birth_date, :social_id])
    end

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
end
