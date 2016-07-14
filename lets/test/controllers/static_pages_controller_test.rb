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
    get static_pages_landing_url
    assert_response :success
    assert_select "title", "#{@base_title} Welcome"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "#{@base_title} About Us"
  end

end
