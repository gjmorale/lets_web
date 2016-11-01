class ProductsController < ApplicationController

	def new
		@product = Product.find(params[:id])
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
	end

	def update
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
