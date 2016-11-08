require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events :one
    @new_event = events :two
    @producer = producers :one
    @owner = accounts :owner_of_producer_one
    @visitor = accounts :two
  end

  def hashed_event event
    params = {params: {event: {
      name: event.name,
      description: event.description,
      capacity: event.capacity,
      min_age: event.min_age,
      max_age: event.max_age,
      open_date: event.open_date, 
      close_date: event.close_date
    }}}
  end

  test "should get new" do
    log_in_as @owner
    get new_producer_event_url @producer
    assert_response :success
  end

  test "should get show" do
    get event_url @event
    assert_response :success
  end

  test "should get edit" do
    log_in_as @owner
    get edit_event_url @event
    assert_response :success
  end

  test "should get index" do
    get producer_events_url @producer
    assert_response :success
  end

  test "should get create" do
    log_in_as @owner
    post producer_events_url @producer, hashed_event(@new_event)
    follow_redirect!
    assert_template "events/show"
  end

  test "should get update" do
    log_in_as @owner
    patch event_url @event, hashed_event(@event)
    follow_redirect!
    assert_template "events/show"
  end

  test "should get destroy" do
    log_in_as @owner
    delete event_url @event
    follow_redirect!
    assert_template "events/index_producer"
  end

  test "should redirect when not logged in" do
    #Case NEW
    get new_producer_event_path @producer
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case CREATE
    post producer_events_path @producer, hashed_event(@new_event)
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case EDIT
    get edit_event_path @event
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case UPDATE
    patch event_path @event, hashed_event(@event)
    assert_not flash.empty?
    assert_redirected_to login_url
    #Case DESTROY
    delete event_url @event
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when not logged in as owner" do
    log_in_as @visitor
    #Case EDIT
    get edit_event_path @event
    assert_not flash.empty?
    assert_redirected_to root_url
    #Case UPDATE
    patch event_path @event, hashed_event(@event)
    assert_not flash.empty?
    assert_redirected_to root_url
    #Case NEW
    get new_producer_event_path @producer
    assert_redirected_to root_url
    #Case CREATE
    post producer_events_path @producer, hashed_event(@new_event)
    assert_redirected_to root_url
    #Case DESTROY
    delete event_url @event
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
