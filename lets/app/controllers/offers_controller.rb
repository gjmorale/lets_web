class OffersController < ApplicationController

	def create
  	@combo = Combo.find(params[:combo_id])
  	@offer = @combo.offers.create(offer_params)
  	if @combo.save
      flash[:success] = "New offer created!"
      redirect_to @combo.event
  	else
  		flash[:danger] = "Couldn't create the offer"
  		redirect_to @combo.event
  	end
	end

	def update
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


end
