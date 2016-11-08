require 'test_helper'

class EventsManipulationTest < ActionDispatch::IntegrationTest

  def setup
  	@producer = producers :one
  	@owner = accounts :owner_of_producer_one
  	@not_owner = accounts :two
  	@event = events :one
    @combo = combos :one
  	@new_event = events :two
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

  test "should be valid" do
    assert @producer.valid?
    assert @owner.valid?
    assert @not_owner.valid?
    assert @event.valid?
    assert @combo.valid?
    assert_not @new_event.valid?
  end

  test "non admin/owners can't create events" do
  	log_in_as @not_owner
  	get new_producer_event_path @producer
  	assert_no_difference "@producer.events.count" do
	  	post producer_events_path @producer, hashed_event(@new_event)
			assert_not flash.empty?
			assert_redirected_to root_url
			@producer.reload
		end
  end

  test "successfull new event added and removed by owner" do
  	#Log as admin
  	log_in_as @owner
  	#Assign new event
  	get new_producer_event_path @producer
  	assert_difference "@producer.events.count", 1 do
	  	post producer_events_path @producer, hashed_event(@new_event)
			follow_redirect!
			assert_not flash.empty?
	    assert_template 'events/show'
			@producer.reload
		end
		#Now remove it
		event_to_delete = @producer.events.find_by name: @new_event.name
		assert_difference "@producer.events.count", -1 do
			delete event_path event_to_delete
			follow_redirect!
			assert_not flash.empty?
	    assert_template 'events/index_producer'
			@producer.reload
		end
  end

  test "owner edits event" do
  	#Log as old owner
  	log_in_as @owner
  	#Assign new role
  	get edit_event_path @event
  	new_description = "This event has been cancelled!!"
  	patch event_path @event, 
										params: { event: { description: new_description } }
		follow_redirect!
		assert_not flash.empty?
    assert_template 'events/show'
		@event.reload
		assert_equal @event.description, new_description
  end

end
