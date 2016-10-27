class ProdOwnersController < ApplicationController
  before_action :logged_in_account, only: [:create, :update, :destroy]
  before_action :is_admin_or_owner, only: [:create, :destroy]
  before_action :is_owner, only: [:update]

	def create
		@prod_owner = ProdOwner.new(prod_owner_params)
    if @prod_owner.save
      flash[:success] = "New owner assigned to producer!"
      redirect_to Producer.find(@prod_owner.producer_id)
    else
      redirect_to root_url
    end
	end

	def update
		@prod_owner = ProdOwner.find(params[:id])
    if @prod_owner.update_attributes(prod_owner_params)
      flash[:success] = "Producer's owner updated!"
      redirect_to Producer.find(@prod_owner.producer_id)
    else
      redirect_to root_url
    end
	end

	def destroy
		@producer = Producer.find(params[:producer_id])
		ProdOwner.find(params[:id]).destroy
    flash[:success] = "Owner successfuly removed from producer"
    redirect_to @producer
	end

	private

		def prod_owner_params
			params.require(:prod_owner).permit(:account_id, :producer_id, :role)
		end

		def is_admin_or_owner
			unless current_account.admin?
	      is_owner
	    end
  	end

  	def is_owner
	  	@producer = Producer.find(params[:producer_id])
  		is_owner? @producer
  	end

end
