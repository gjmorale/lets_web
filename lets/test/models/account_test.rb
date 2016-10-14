require 'test_helper'

class AccountTest < ActiveSupport::TestCase

	def setup
		@account = Account.new(email: "prueba@uno.com", password: "clave123", password_confirmation: "clave123")
    @user = User.new(first_name: "Red", last_name: "PowerRanger", birth_date: DateTime.parse("1991-03-14 10:10:10"), gender: 1, social_id: "17.700.955-5")
    @account.user = @user
	end

	test "should be valid" do
		assert @account.valid?, "Account should be valid"
	end

	test "email should be valid" do
		@account.email = nil
		assert_not @account.valid?, "Nil emails should not be valid"
		@account.email = "      "
		assert_not @account.valid?, "Blank emails should not be valid"
		@account.email = "hola"
		assert_not @account.valid?, "invalid emails should not be valid"
		@account.email = "bien@mail.com"
		assert @account.valid?, "Valid emails should be valid"
		@account.email = "Bien@Mail.com"
		assert @account.valid?, "Valid emails should be valid"
	end

	test "email addresses should be unique" do
    duplicate_account = @account.dup
    duplicate_account.email = @account.email.upcase
    @account.save
    assert_not duplicate_account.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @account.email = mixed_case_email
    @account.save
    assert_equal mixed_case_email.downcase, @account.reload.email
  end

  test "password should be valid" do
  	@account.password = @account.password_confirmation = nil
  	assert_not @account.valid?, "Password can't be nil"
  	@account.password = @account.password_confirmation = " "*8
  	assert_not @account.valid?, "Password can't be blank"
  	@account.password = @account.password_confirmation = "a"*5
  	assert_not @account.valid?, "Password can't be shorter than 6 characters"
  	@account.password = @account.password_confirmation = "a"*13
  	assert_not @account.valid?, "Password can't be longer than 12 characters"
  	@account.password = @account.password_confirmation = "kajf8274"
  	assert @account.valid?, "Valid passwords should be accepted"
  end

  test "authenticated? should return false for accounts with nil digest" do
    assert_not @account.authenticated?('')
  end

end
