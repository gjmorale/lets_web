require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should get show" do
    get account_url accounts :one
    assert_response :success
  end

end
