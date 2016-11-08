class OffersController < ApplicationController
  before_action :logged_in_account, only: [:create, :update, :destroy]
  before_action :account_is_owner, only: [:create, :update, :destroy]

	def create
  	@combo = Combo.find(params[:combo_id])
  	@offer = @combo.offers.create(offer_params)
  	if @combo.save
      flash[:success] = "New offer created!"
      redirect_to @combo
  	else
  		flash[:danger] = "Couldn't create the offer"
  		render 'combos/show'
  	end
	end

	def update
  	@offer = Offer.find(params[:id])
  	@combo = @offer.combo
  	if @offer.update_attributes(offer_params)
      flash[:success] = "Offer updated!"
      redirect_to @combo.event
  	else
  		@offer = Offer.new()
  		flash[:danger] = "Couldn't update offer"
  		render 'combos/show'
  	end
	end

	def destroy
		@offer = Offer.find(params[:id])
		@event = @offer.combo.event
		@offer.destroy
		flash[:success] = "Offer removed"
		redirect_to @event
	end

	private
		
		def offer_params
			params.require(:offer).permit(
				:price,
		    :redeem_start,
		    :redeem_finish,
		    :product_id)
		end

		def account_is_owner
			if (combo_id = params[:combo_id]).nil?
				offer = Offer.find(params[:id])
				event = offer.combo.event unless offer.nil? or offer.combo.nil?
			else
				combo = Combo.find(combo_id)
				event = combo.event unless combo.nil?
			end

			if event.nil?
				flash[:danger] = 'Invalid data'
				redirect_to root_url
			else
				account_is_owner? event.producer
			end
		end


end
