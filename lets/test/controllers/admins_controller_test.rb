require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@admin = accounts :one
		@not_admin = accounts :owner_of_producer_one
		@user = users :two
	end

  test "should get create" do
  	assert @admin.admin?
  	assert_not @user.account.admin?
  	#Case NOT LOGGED IN
  	post admin_user_url @user
    assert_redirected_to login_url
    #Case NOT ADMIN
    log_in_as @not_admin
  	post admin_user_url @user
    assert_redirected_to root_url
    #Case ADMIN SUCCESS
    log_in_as @admin
  	post admin_user_url @user
    assert_redirected_to user_url @user
    assert_not flash[:success].nil?
    #After SUCCESS
    @user.reload
    assert @user.account.admin?
  end

  test "should get destroy" do
  	@user.toggle_admin true
  	assert @admin.admin?
  	assert @user.account.admin?
  	#Case NOT LOGGED IN
  	delete admin_user_url @user
    assert_redirected_to login_url
    #Case NOT ADMIN
    log_in_as @not_admin
  	delete admin_user_url @user
    assert_redirected_to root_url
    #Case ADMIN FAILED ID
    log_in_as @admin
  	delete admin_user_url @admin.user
    assert_redirected_to @admin.user
    assert_not flash[:danger].nil?
    #Case ADMIN SUCCESS
    log_in_as @admin
  	delete admin_user_url @user
    assert_redirected_to user_url @user
    assert_not flash[:success].nil?
    #After SUCCESS
    @user.reload
    assert_not @user.account.admin?
  end
end
