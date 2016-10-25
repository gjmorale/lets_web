class ProducersController < ApplicationController
  before_action :logged_in_account, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_admin, only: [:new, :create, :destroy]
  before_action :is_producer_admin, only: [:edit, :update]

  def show
  	@producer = Producer.find(params[:id])
  end

  def new
  	@producer = Producer.new()
  end

  def create
  	@producer = Producer.new(producer_params)
    if @producer.save
      flash[:success] = "Producer created!"
      redirect_to @producer
    else
      render 'new'
    end
  end

  def edit
  	@producer = Producer.find(params[:id])
  end

  def update
  end

  private

  	def producer_params
      params.require(:producer).permit(:name, :fantasy_name,
               :social_id)
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

  	def is_producer_admin
  		@producer = Producer.find(params[:id])
      redirect_to root_url unless @producer.admins.exists?(current_account.id)
  	end
end
