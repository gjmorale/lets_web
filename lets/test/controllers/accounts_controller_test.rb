require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@account = accounts :one
		@other_account = accounts :two
	end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should get show" do
    get account_url accounts :one
    assert_response :success
  end

  test "should not allow edit of privileged parameters" do
  	log_in_as @other_account
  	assert_not @other_account.admin?
  	patch account_path @other_account, params: { account: { password: "password",
  																									password_confirmation: "password",
  																									admin: true }}
		assert_not @other_account.admin?
  end

end
