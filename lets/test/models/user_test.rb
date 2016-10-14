require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @account = Account.new(email: "prueba@uno.com", password: "clave123", password_confirmation: "clave123")
  	@user = User.new(first_name: "Red", last_name: "PowerRanger", birth_date: DateTime.parse("1991-03-14 10:10:10"), gender: 1, social_id: "17.700.955-5")
    @user.account = @account
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
  	assert_not @user.valid?, "Can't contain consecutive white spaces"
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
  	assert_not @user.valid?, "Can't contain consecutive white spaces"
  end

  test "birth_date should be valid" do
  	@user.birth_date = "      "
  	assert_not @user.valid?, "Can't be blank"
  	@user.birth_date = 5.years.ago
  	assert_not @user.valid?, "Must be over 5 years old"
  	@user.birth_date = 100.years.ago - 1.day
  	assert_not @user.valid?, "Must be under 100 years old"
  end

  test "gender should be valid" do
  	@user.gender = 1
  	assert @user.valid?, "Can be male"
  	@user.gender = 0
  	assert @user.valid?, "Can be female"
  	@user.gender = -1
  	assert_not @user.valid?, "Can't be anything else"
  end

  test "social_id should be valid" do
    @user.social_id = nil
    assert_not @user.valid?, "Rut can't be nil"
    @user.social_id = "      "
    assert_not @user.valid?, "Rut can't be blank"
  	@user.social_id = "17.700.800-1"
  	assert @user.valid?, "Verifying digit must be valid"
  	@user.social_id = "17700955-5"
  	assert @user.valid?, "Without dots must be valid"
  	@user.social_id = "11788935-5"
  	assert_not @user.valid?, "Invalid verifying digits must be invalid"
  	@user.social_id = "1a78j93@-5"
  	assert_not @user.valid?, "Invalid characters must be invalid"
  end

  test "social_id should be unique" do
    duplicate_user = @user.dup
    @user.social_id = "17.700.955-5"
    duplicate_user.social_id = "17.700.955-5"
    @user.save
    assert_not duplicate_user.valid?, "Social_id should be unique"
    @user.social_id = "17.700.955-5"
    duplicate_user.social_id = "17700955-5"
    @user.save
    assert_not duplicate_user.valid?, "Social_id should be unique indiferent of dots"
  end

end
