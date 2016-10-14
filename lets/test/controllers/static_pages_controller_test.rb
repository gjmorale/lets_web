require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	def setup
    @base_title = "LET'S"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get landing" do
    get landing_url
    assert_response :success
    assert_select "title", "#{@base_title} Welcome"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "#{@base_title} About Us"
  end

end
