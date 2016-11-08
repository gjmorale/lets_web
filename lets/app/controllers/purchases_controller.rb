class PurchasesController < ApplicationController
  before_action :logged_in_account
  before_action :user_is_owner, only: [:show, :index, :destroy]

	def create
		@combo = Combo.find(params[:combo_id])
		@user = current_user
		if @combo.buy @user
			flash[:success] = "New products purchased"
			redirect_to user_purchases_path @user
		else
			@errors = @combo.buyable @user
			@offer = Offer.new()
			flash[:danger] = "Couldn't buy product"
			render 'combos/show'
		end
	end

	def destroy
		@purchase = Purchase.find(params[:id])
		@purchase.reinburse
		@user = @purchase.buyer
		@purchase.destroy
		flash[:success] = "Purchase canceled"
		redirect_to @user
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def index
		@user = User.find(params[:user_id])
		@purchases = @user.purchases
	end

	private

		def user_is_owner
			if (user_id = params[:user_id]).nil?
				purchase = Purchase.find(params[:id])
				user = purchase.buyer unless purchase.nil?
			else
				user = User.find(user_id)
			end

			if user.nil? or current_user.id != user.id
				flash[:danger] = 'Invalid user'
				redirect_to root_url
			end
		end

end
