require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users :one
    @other_user = users :two
  end

  test "should get show" do
    get user_url @user
    assert_response :success
  end

  test "should get edit" do
    log_in_as @user.account
    get edit_user_url @user
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              birth_date: @user.birth_date,
                                              gender: @user.gender,
                                              social_id: @user.social_id } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user.account)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user.account)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              birth_date: @user.birth_date,
                                              gender: @user.gender,
                                              social_id: @user.social_id } }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
