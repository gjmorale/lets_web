require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@owner = accounts :owner_of_producer_one
  	@not_owner = accounts :two
  	@offer = offers :one
  	@combo = @offer.combo
  	@event = @combo.event
  	@new_offer = offers :two
  end

  def hashed_offer offer
		params = {params: {offer: {
	    price: offer.price,
	    redeem_start: offer.redeem_start,
	    redeem_finish: offer.redeem_finish,
	    product_id: offer.product_id
	    }}}
	end
  	
  test "should get create" do
  	#Case NOT LOGGED IN
  	post combo_offers_url @combo, hashed_offer(@new_offer)
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
  	post combo_offers_url @combo, hashed_offer(@new_offer)
    assert_redirected_to root_url
    #Case OWNER FAILED VALIDATION
    log_in_as @owner
    @offer.price = -10
  	post combo_offers_url @combo, hashed_offer(@offer)
    assert_not flash[:danger].nil?
    assert_template 'events/show'
    #Case OWNER SUCCESS
    log_in_as @owner
  	post combo_offers_url @combo, hashed_offer(@new_offer)
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end

  test "should get update" do
  	#Case NOT LOGGED IN
  	patch offer_url @offer, hashed_offer(@offer)
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
  	patch offer_url @offer, hashed_offer(@offer)
    assert_redirected_to root_url

    log_in_as @owner
    #Case OWNER FAILED ID
    assert @new_offer.combo.nil?
  	patch offer_url @new_offer, hashed_offer(@new_offer)
    assert_redirected_to root_url
    assert_not flash[:danger].nil?
    #Case OWNER FAILED VALIDATION
    @offer.price = -10
    patch offer_url @offer, hashed_offer(@offer)
    assert_not flash[:danger].nil?
    assert_template 'events/show'
    #Case OWNER SUCCESS
    @offer.reload
    patch offer_url @offer, hashed_offer(@offer)
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end

  test "should get destroy" do
  	#Case NOT LOGGED IN
  	delete offer_url @offer
    assert_redirected_to login_url
    #Case NOT OWNER
    log_in_as @not_owner
  	delete offer_url @offer
    assert_redirected_to root_url
    #Case OWNER FAILED ID
    log_in_as @owner
  	delete offer_url @new_offer
    assert_redirected_to root_url
    assert_not flash[:danger].nil?
    #Case OWNER SUCCESS
    log_in_as @owner
  	delete offer_url @offer
    assert_redirected_to event_url @event
    assert_not flash[:success].nil?
  end
end
