require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products :one
    @new_product = products :two
    @admin = accounts :one
    @not_admin = accounts :two
  end

  def hashed_product product
    params = {params: {product: {
			name: product.name,
	    description: product.description,
	    min_age: product.min_age,
	    product_type: product.product_type
			}}}
  end

  test "should get new" do
    log_in_as @admin
    get new_product_url 
    assert_response :success
  end

  test "should get show" do
    get product_url @product
    assert_response :success
  end

  test "should get edit" do
    log_in_as @admin
    get product_url @product
    assert_response :success
  end

  test "should get index" do
    get products_url 
    assert_response :success
  end

  test "should get create" do
    log_in_as @admin
    post products_url hashed_product(@new_product)
    follow_redirect!
    assert_template "products/show"
  end

  test "should get update" do
    log_in_as @admin
    patch product_url @product, hashed_product(@product)
    follow_redirect!
    assert_template "products/show"
  end

  test "should get destroy" do
    log_in_as @admin
    delete product_url @product
    follow_redirect!
    assert_template "products/index"
  end

  test "should redirect when not logged in" do
    #Case NEW
    get new_product_path
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case CREATE
    post products_path hashed_product(@new_product)
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case EDIT
    get edit_product_path @product
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case UPDATE
    patch product_path @product, hashed_product(@product)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when not logged in as admin" do
    log_in_as @not_admin
    #Case EDIT
    get edit_product_path @product
    assert_not flash.empty?
    assert_redirected_to root_url
    #Case UPDATE
    patch product_path @product, hashed_product(@product)
    assert_not flash.empty?
    assert_redirected_to root_url
    #Case NEW
    get new_product_path
    assert_redirected_to root_url
    #Case CREATE
    post products_path, hashed_product(@new_product)
    assert_redirected_to root_url
  end
end
