class ProducersController < ApplicationController
  before_action :logged_in_account, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_admin, only: [:new, :create, :destroy]
  before_action :account_is_owner, only: [:edit, :update]

  def show
  	@producer = Producer.find(params[:id])
    if current_admin? or is_owner? @producer
      @prod_owner = ProdOwner.new() 
    end
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

  	def account_is_owner
  		@producer = Producer.find(params[:id])
      account_is_owner? @producer
  	end
end
