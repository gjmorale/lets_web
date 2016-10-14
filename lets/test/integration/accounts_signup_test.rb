require 'test_helper'

class AccountsSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Account.count' do
      post accounts_path, params: { account: { email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'accounts/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'Account.count', 1 do
      post accounts_path, params: { account: { email: "primer@ejemplo.com",
                                         password:              "password",
                                         password_confirmation: "password",
                                         user_attributes: { first_name: 'Primer',
                                         		last_name: 'Cliente',
                                         		social_id: '17700955-5',
                                         		gender: '0',
                                         		birth_date: DateTime.parse("1991-03-14 10:10:10")	} } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end