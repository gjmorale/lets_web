class EventsController < ApplicationController
  before_action :logged_in_account, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_admin_or_owner, only: [:destroy]
  before_action :account_is_owner, only: [:new, :create, :edit, :update, :destroy]

  def new
  	@producer = Producer.find(params[:producer_id])
  	@event = @producer.events.create()
  end

  def show
  	@event = Event.find(params[:id])
  end

  def edit
  	@event = Event.find(params[:id])
  end

  def index
  	@event = Event.all
  end

  def create
  end

  def update
  end

  def destroy
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
        event = ProdOwner.find(params[:id])
        producer = event.producer
      else
        producer = Producer.find(params[:producer_id])
      end
  		account_is_owner? producer
  	end
end
