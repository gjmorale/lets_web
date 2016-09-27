class AccountsController < ApplicationController
  def new
  end

  def show
  	@account = Account.find(params[:id])
  end
end
