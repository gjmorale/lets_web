class CombosController < ApplicationController
  before_action :logged_in_account, only: [:show, :new, :create, :update, :destroy]
  before_action :account_is_owner, only: [:new, :create, :update, :destroy]

  def show
  	@combo = Combo.find(params[:id])
  	@offer = Offer.new()
  end

  def new
  	@event = Event.find(params[:event_id])
  	@combo = Combo.new()
  end

	def create
  	@event = Event.find(params[:event_id])
  	@combo = @event.combos.create(combo_params)
  	if @event.save
      flash[:success] = "New combo created!"
      redirect_to @event
  	else
  		flash[:danger] = "Couldn't create the combo"
  		render 'new'
  	end
	end

	def update
  	@combo = Combo.find(params[:id])
  	@event = @combo.event
  	if @combo.update_attributes(combo_params)
      flash[:success] = "Combo updated!"
      redirect_to @event
  	else
  		flash[:danger] = "Couldn't update the combo"
  		render 'events/show'
  	end
	end

	def destroy
		@combo = Combo.find(params[:id])
		@event = @combo.event
		@combo.destroy
		flash[:success] = "Combo removed"
		redirect_to @event
	end

	private
		
		def combo_params
			params.require(:combo).permit(
				:name,
		    :description,
		    :buyable_from,
		    :buyable_until,
		    :min_age,
		    :max_age,
		    :gender,
		    :stock)
		end

		def account_is_owner
			if (event_id = params[:event_id]).nil?
				combo = Combo.find(params[:id])
				event = combo.event unless combo.nil?
			else
				event = Event.find(event_id)
			end

			if event.nil?
				flash[:danger] = 'Invalid data'
				redirect_to root_url
			else
				account_is_owner? event.producer
			end
		end

end
