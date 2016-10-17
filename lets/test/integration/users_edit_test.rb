require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name: "Red",
																				     last_name: "PowerRanger",
																				     birth_date: DateTime.parse("1991-03-14 10:10:10"),
																				     gender: 1,
																				     social_id: "17.700.955-1" } }

    assert_template 'users/edit'
  end
end
