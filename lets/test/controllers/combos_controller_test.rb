require 'test_helper'

class CombosControllerTest < ActionDispatch::IntegrationTest

  def setup
  	@owner = accounts :owner_of_producer_one
  	@not_owner = accounts :two
  	@combo = combos :one
  	@event = @combo.event
  	@new_combo = combos :two
  end

  def hashed_combo combo
		params = {params: {combo: {
			name: combo.name,
	    description: combo.description,
	    buyable_from: combo.buyable_from,
	    buyable_until: combo.buyable_until,
	    min_age: combo.min_age,
	    max_age: combo.max_age,
	    gender: combo.gender,
	    stock: combo.stock
			}}}
	end
  	
  test "should get create" do
  	#Case NOT LOGGED IN
  	post event_combos_url @event, hashed_combo(@new_combo)
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
    post event_combos_url @event, hashed_combo(@new_combo)
    assert_redirected_to root_url
    #Case OWNER FAILED VALIDATION
    log_in_as @owner
    @combo.stock = -10
    post event_combos_url @event, hashed_combo(@combo)
    assert_not flash[:danger].nil?
    assert_template 'events/show'
    #Case OWNER SUCCESS
    log_in_as @owner
    post event_combos_url @event, hashed_combo(@new_combo)
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end

  test "should get update" do
  	#Case NOT LOGGED IN
  	patch combo_url @combo, hashed_combo(@combo)
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
    patch combo_url @combo, hashed_combo(@combo)
    assert_redirected_to root_url

    log_in_as @owner
    #Case OWNER FAILED ID
    assert @new_combo.event.nil?
    patch combo_url @new_combo, hashed_combo(@new_combo)
    assert_redirected_to root_url
    assert_not flash[:danger].nil?
    #Case OWNER FAILED VALIDATION
    @combo.stock = -10
    patch combo_url @combo, hashed_combo(@combo)
    assert_not flash[:danger].nil?
    assert_template 'events/show'
    #Case OWNER SUCCESS
    @combo.reload
    @combo.stock = 555
    patch combo_url @combo, hashed_combo(@combo)
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end

  test "should get destroy" do
  	#Case NOT LOGGED IN
  	delete combo_url @combo
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
    delete combo_url @combo
    assert_redirected_to root_url
    #Case OWNER FAILED ID
    log_in_as @owner
    delete combo_url @new_combo
    assert_redirected_to root_url
    assert_not flash[:danger].nil?
    #Case OWNER SUCCESS
    log_in_as @owner
    delete combo_url @combo
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end
end
