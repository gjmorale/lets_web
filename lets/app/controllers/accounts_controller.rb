class AccountsController < ApplicationController
  def new
  	@account = Account.new
  end

  def show
  	@account = Account.find(params[:id])
  end

  def create
  	@account = Account.new(account_params)
    if @account.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private
  	def account_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end
end
