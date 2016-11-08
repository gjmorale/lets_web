require 'test_helper'

class UserBuysProductTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users :client
  	@event = events :event_of_eu
  	@product = products :product_of_eu
  	@combo = combos :combo_of_eu
  end

  test "should be valid" do
  	assert @user.valid?
  	assert @event.valid?
  	assert @product.valid?
  	assert @combo.valid?
  end

  test "user buys product and is admitted" do
  	#assert_equal 0, @user.purchases.count
  	#@combo.buy @user
  	#assert_equal @combo.offers.count, @user.purchases.count
  	#@admission = Admission.find_by(user_id: @user.id)
  	#assert_not @purchase.nil?
  	#@purchase = Purchase.find_by(user_id: @user.id)
  	#assert_not @admission.nil?
  	#assert_equal @event.id, @admission.event_id 
  end
end
