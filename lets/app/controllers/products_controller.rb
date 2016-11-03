class ProductsController < ApplicationController
  before_action :logged_in_account, only: [:new, :create, :edit, :update, :destroy]	
  before_action :is_admin, only: [:new, :create, :edit, :update, :destroy]	

	def new
		@product = Product.new()
	end

	def create
  	@product = Product.new(product_params)
  	if @product.save
      flash[:success] = "New product created!"
      redirect_to @product
  	else
  		flash[:danger] = "Couldn't create the product"
  		render 'new'
  	end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(product_params)
      flash[:success] = "New product updated!"
      redirect_to @product
    else
  		flash[:danger] = "Couldn't update the product"
  		render 'edit'
  	end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		flash[:success] = "Product deleted"
		redirect_to products_path
	end

	def show
		@product = Product.find(params[:id])
	end

	def index
    @products = Product.paginate(page: params[:page])
	end

	private

		def product_params
			params.require(:product).permit(
				:name,
		    :description,
		    :min_age,
		    :product_type)
		end

end
