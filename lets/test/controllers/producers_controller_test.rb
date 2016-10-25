require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @producer = producers :one
    @admin = accounts :one
    @admin_account = accounts :admin_of_producer_one
  end

  test "should get show" do
    get producer_path @producer
    assert_response :success
  end

  test "should get new" do
    log_in_as @admin
    get new_producer_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as @admin_account
    get edit_producer_path @producer
    assert_response :success

  end

end
