require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
  	@product = Product.new(name: "Piscola Coca-Normal", description: "Pisco + Coca Normal con Hielo", min_age: 18, grants_admission: 0, admission_level: 1)
  end

  test "should be valid" do
    @product.name = "12345abc"
    @product.description = "123456789abc"
    @product.min_age = "18"
    @product.grants_admission = 1
    @product.admission_level = 3
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

  test "grants_admission should be valid" do 
  	@product.grants_admission = nil
  	assert_not @product.valid?, "Null grants_admission should not be accepted"
  	@product.grants_admission = "Falso"
  	assert_not @product.valid?, "Invalid grants_admission should not be accepted"
  	@product.grants_admission = 1
  	assert @product.valid?, "Valid true grants_admission should be accepted"
  	@product.grants_admission = 0
  	assert @product.valid?, "Valid false grants_admission should be accepted"
  end

  test "admission_level should be valid" do 
  	@product.admission_level = nil
  	assert_not @product.valid?, "Admission_level can't be null"
  	@product.admission_level = -1
  	assert_not @product.valid?, "Stock can't be negative"
  	@product.admission_level = 6
  	assert_not @product.valid?, "Stock can't be grater than 5"
  	@product.admission_level = 4
  	assert @product.valid?, "Valid admission_levels must be accepted"
  end

end
