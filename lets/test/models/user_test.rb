require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(first_name: "Red", last_name: "PowerRanger", birth_date: DateTime.parse("1991-03-14 10:10:10"), gender: 1, social_id: "11.222.333-4")
  end

  test "should be valid" do
  	assert @user.valid?	
  end

  test "first_name should be valid" do
  	@user.first_name = "      "
  	assert_not @user.valid?, "Can't be blank"
  	@user.first_name = "a"*51
  	assert_not @user.valid?, "Can't be longer than 50 characters"
  	@user.first_name = "b"
  	assert_not @user.valid?, "Can't be shorter than 2 characters"
  	@user.first_name = "123"
  	assert_not @user.valid?, "Can't contain non alphabetical characters"
	@user.first_name = "Jhonn Slick Red"
  	assert @user.valid?, "Can contain non consecutive white spaces"
	@user.first_name = "Jhonn  Red"
  	assert @user.valid?, "Can't contain consecutive white spaces"
  end

  test "last_name should be valid" do
  	@user.last_name = "      "
  	assert_not @user.valid?, "Can't be blank"
  	@user.last_name = "a"*51
  	assert_not @user.valid?, "Can't be longer than 50 characters"
  	@user.last_name = "b"
  	assert_not @user.valid?, "Can't be shorter than 2 characters"
  	@user.last_name = "123"
  	assert_not @user.valid?, "Can't contain non alphabetical characters"
	@user.last_name = "Jhonn Slick Red"
  	assert @user.valid?, "Can contain non consecutive white spaces"
	@user.last_name = "Jhonn  Red"
  	assert @user.valid?, "Can't contain consecutive white spaces"
  end

  test "birth_date should be valid" do
  	@user.birth_date = "      "
  	assert_not @user.valid?, "Can't be blank"
  	@user.birth_date = DateTime.now
  	assert_not @user.valid?, "Must be over 5 years old"
  	@user.birth_date = 100.years.ago
  	assert_not @user.valid?, "Must be under 100 years old"
  end

  test "gender should be valid" do
  	@user.gender = 1
  	assert @user.valid?, "Can be male"
  	@user.gender = "0"
  	assert @user.valid?, "Can be female"
  	@user.gender = -1
  	assert_not @user.valid?, "Can't be anything else"
  end

end
