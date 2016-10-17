require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    log_in_as @user.account 
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name: "Réd",
																				     last_name: "PowerRaaaaaaaaanger",
																				     birth_date: DateTime.parse("2020-03-14 10:10:10"),
																				     gender: 1,
																				     social_id: "17.700.955-1" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
  	log_out
    get edit_user_path(@user)
    log_in_as(@user.account)
    assert_redirected_to edit_user_url(@user)
  	user = users(:two)
  	#Change all but social_id wich must be unique
  	patch user_path(@user), params: { user: { first_name: user.first_name,
																				     last_name: user.last_name,
																				     birth_date: user.birth_date,
																				     gender: user.gender,
																				     social_id: @user.social_id } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal user.first_name	, @user.first_name
    assert_equal user.last_name		, @user.last_name
    assert_equal user.birth_date	, @user.birth_date
    assert_equal user.gender			, @user.gender
  end
end
