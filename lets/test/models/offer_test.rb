require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  def setup
  	@offer = offers :one
  end

  test "should be valid" do
  	assert @offer.valid?	
  end

  test "redeem_start date should be valid" do 
  	@offer.redeem_start = nil
  	assert_not @offer.valid?, "Null dates should not be accepted"
  	@offer.redeem_start = 1.months.from_now
  	assert @offer.valid?, "Valid dates should be accepted"
  	@offer.redeem_start = "60-60-60"
  	assert_not @offer.valid?, "Invalid dates should not be accepted"
  end

  test "redeem_finish date should be valid" do 
  	@offer.redeem_finish = nil
  	assert_not @offer.valid?, "Null dates should not be accepted"
  	@offer.redeem_finish = 1.months.from_now
  	assert @offer.valid?, "Valid dates should be accepted"
  	@offer.redeem_finish = "60-60-60"
  	assert_not @offer.valid?, "Invalid dates should not be accepted"
  end

  test "price should be valid" do 
  	@offer.price = nil
  	assert_not @offer.valid?, "Null prices should not be accepted"
  	@offer.price = -13
  	assert_not @offer.valid?, "Negative prices should not be accepted"
  	@offer.price = 1000001
  	assert_not @offer.valid?, "Prices over 1.000.000 should not be accepted"
  	@offer.price = 25
  	assert @offer.valid?, "Valid prices should be accepted"
  end

end
