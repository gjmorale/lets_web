require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_url users :one
    assert_response :success
  end

  test "should get update" do
    put user_url users :one
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url users :one
    assert_response :success
  end

end
