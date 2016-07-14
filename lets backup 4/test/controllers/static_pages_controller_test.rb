require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

	def setup
    @base_title = "LET'S"
  end

  test "should get root" do
    assert_routing(root_url, controller: "static_pages", action: "landing") # 3 asserts: {url, controller, action}
    assert_response :success
  end

  test "should get landing" do
    get :landing
    assert_response :success
    assert_select "title", "#{@base_title} Welcome"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "#{@base_title} About Us"
  end

end
