class CombosController < ApplicationController

	def create
  	@event = Event.find(params[:event_id])
  	@combo = @event.combos.create(combo_params)
  	if @event.save
      flash[:success] = "New combo created!"
      redirect_to @event
  	else
  		flash[:danger] = "Couldn't create the combo"
  		render 'show'
  	end
	end

	def update
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

end
