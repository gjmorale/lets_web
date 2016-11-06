require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  
  def setup
  	@purchase = purchases :one
  	@user = users :one
  	@offer = offers :one
    @client = users :client
    @young_client = users :young_client
  end

  test "should be valid" do
  	assert @purchase.valid?
  end

  test "date should be valid" do
  	@purchase.date = nil
  	assert_not @purchase.valid?, "Null dates should not be accepted"
  	@purchase.date = 1.months.from_now
  	assert @purchase.valid?, "Valid dates should be accepted"
  	@purchase.date = "60-60-60"
  	assert_not @purchase.valid?, "Invalid dates should not be accepted"
	end

  test "qr should be valid" do
  	@purchase.qr = "      "
  	assert_not @purchase.valid?, "Can't be blank"
  	@purchase.qr = "a"*251
  	assert_not @purchase.valid?, "Can't be longer than 250 characters"
  	@purchase.qr = "b"*249
  	assert_not @purchase.valid?, "Can't be shorter than 250 characters"
	  @purchase.qr = '!"#$%&/()='*25
  	assert_not @purchase.valid?, "Can't contain any other character"
  	@purchase.qr = "ABCabc123" + 'Z'*241
  	assert @purchase.valid?, "Can contain letters and numbers"
	end

  test "price_paid should be valid" do
  	@purchase.price_paid = nil
  	assert_not @purchase.valid?, "Null price_paids should not be accepted"
  	@purchase.price_paid = -13
  	assert_not @purchase.valid?, "Negative price_paids should not be accepted"
  	@purchase.price_paid = 1000001
  	assert_not @purchase.valid?, "Prices over 1.000.000 should not be accepted"
  	@purchase.price_paid = 25
  	assert @purchase.valid?, "Valid price_paids should be accepted"
	end

  test "status should be valid" do
  	@purchase.status = nil
  	assert_not @purchase.valid?, "Null statuses should not be accepted"
  	@purchase.status = -1
  	assert_not @purchase.valid?, "Negative statuses should not be accepted"
  	@purchase.status = 4
  	assert_not @purchase.valid?, "Statuses over 3 should not be accepted"
  	@purchase.status = 2
  	assert @purchase.valid?, "Valid statuses should be accepted"
	end

  test "should generate purchases" do
    purchase = Purchase.generate(@client, @offer)
    assert_not purchase.nil?
  end
end
