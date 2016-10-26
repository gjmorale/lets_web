require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @producer = producers :one
    @admin = accounts :one
    @owner = accounts :admin_of_producer_one
    @not_owner = accounts :two
  end

  test "should get show" do
    get producer_path @producer
    assert_response :success
  end

  test "should get new" do
    log_in_as @admin
    get new_producer_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as @owner
    get edit_producer_path @producer
    assert_response :success
  end

  test "should redirect when not logged in" do
    #Case NEW
    get new_producer_path
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case CREATE
    post producers_path, params: { producer: { name: @producer.name,
                                              fantasy_name: @producer.fantasy_name,
                                              social_id: @producer.social_id } }
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case EDIT
    get edit_producer_path @producer
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case UPDATE
    patch producer_path @producer, params: { producer: { name: @producer.name,
                                              fantasy_name: @producer.fantasy_name,
                                              social_id: @producer.social_id } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when not logged in as owner" do
    log_in_as @not_owner
    #Case EDIT
    get edit_producer_path @producer
    assert_not flash.empty?
    assert_redirected_to root_url
    #Case UPDATE
    patch producer_path @producer, params: { producer: { name: @producer.name,
                                              fantasy_name: @producer.fantasy_name,
                                              social_id: @producer.social_id } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect when not logged in as admin" do
    log_in_as @not_owner
    #Case NEW
    get new_producer_path
    assert_redirected_to root_url
    #Case CREATE
    post producers_path, params: { producer: { name: @producer.name,
                                              fantasy_name: @producer.fantasy_name,
                                              social_id: @producer.social_id } }
    assert_redirected_to root_url
  end

end
