require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
  	@product = Product.new(name: "Piscola Coca-Normal", description: "Pisco + Coca Normal con Hielo", min_age: 18, product_type: 1)
  end

  test "should be valid" do
    @product.name = "12345abc"
    @product.description = "123456789abc"
    @product.min_age = "18"
    @product.product_type = 1
  	assert @product.valid?	
  end

  test "name should be valid" do
  	@product.name = "       "
  	assert_not @product.valid?, "Name can't be blank"
  	@product.name = "a"*51
  	assert_not @product.valid?, "Name can't be longer than 50 characters"
  	@product.name = "b"*4
  	assert_not @product.valid?, "Name can't be shorter than 5 characters"
  	@product.name = "%/()="
  	assert_not @product.valid?, "Name can't contain non alphanumerical characters except ! ? $ & . , : # @ - "
  	@product.name = "El  Producto"
  	assert_not @product.valid?, "Name can't contain consecutive whitespaces"
  	@product.name = "La Piscola: Lo Mejor!! para tod@s"
  	assert @product.valid?, "Valid name should be accepted"
  end

  test "description should be valid" do 
  	@product.description = "      "
  	assert_not @product.valid?, "Description can't be blank"
  	@product.description = "a"*251
  	assert_not @product.valid?, "Description can't be longer than 250 characters"
  	@product.description = "b"*9
  	assert_not @product.valid?, "Description can't be shorter than 10 characters"
  	@product.description = "Esta es una descripción válida."
  	assert @product.valid?, "Valid descriptions must be accepted"
  end

  test "min_age should be valid" do 
  	@product.min_age = nil
  	assert_not @product.valid?, "Null age should not be accepted"
  	@product.min_age = 13
  	assert_not @product.valid?, "Ages under 14 should not be accepted"
  	@product.min_age = 101
  	assert_not @product.valid?, "Ages over 100 should not be accepted"
  	@product.min_age = 25
  	assert @product.valid?, "Valid ages should be accepted"
  end

  test "product_type should be valid" do 
  	@product.product_type = nil
  	assert_not @product.valid?, "Null product_type should not be accepted"
  	@product.product_type = "Falso"
  	assert_not @product.valid?, "Invalid product_type should not be accepted"
  	@product.product_type = 0
  	assert_not @product.valid?, "Type should be greater than 0"
    @product.product_type = 3
    assert_not @product.valid?, "Type should be less than 3"
    @product.product_type = 1
    assert @product.valid?, "Valid product_type should be accepted"
  end
  
end
