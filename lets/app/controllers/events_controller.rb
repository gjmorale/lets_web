class EventsController < ApplicationController
  before_action :logged_in_account, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_admin_or_owner, only: [:destroy]
  before_action :account_is_owner, only: [:new, :create, :edit, :update, :destroy]

  def new
  	@producer = Producer.find(params[:producer_id])
  	@event = Event.new()
  end

  def show
  	@event = Event.find(params[:id])
  end

  def edit
  	@event = Event.find(params[:id])
  end

  def index
  	@producer = Producer.find(params[:producer_id])
  	@events = @producer.events
  end

  def create
  	@producer = Producer.find(params[:producer_id])
  	@event = @producer.events.create(event_params)
  	if @producer.save
      flash[:success] = "New event created!"
      redirect_to @event
  	else
  		redirect_to root_url
  	end
  end

  def update
		@event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to @event
    else
      redirect_to root_url
    end
  end

  def destroy
		event = Event.find(params[:id])
    producer = event.producer
    if event.destroy
	    flash[:success] = "Event successfuly removed"
	    redirect_to producer_events_url producer
	  else
	  	flash[:danger] = "Event can't be removed now"
	  	redirect_to root_url
	  end
  end

  private

  	def event_params
			params.require(:event).permit(:name, :description, :capacity, :min_age, :max_age, :open_date, :close_date)
		end

		def is_admin_or_owner
			unless current_account.admin?
	      account_is_owner
	    end
  	end

  	def account_is_owner
      if params[:producer_id].nil?
        event = Event.find(params[:id])
        producer = event.producer
      else
        producer = Producer.find(params[:producer_id])
      end
  		account_is_owner? producer
  	end
end
