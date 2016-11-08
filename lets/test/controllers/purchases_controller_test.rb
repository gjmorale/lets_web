require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
	
	def setup
		@combo = combos :combo_of_eu
		@client = users :client
		@young_client = users :young_client
		@purchase = purchases :one
		@other_purchase = purchases :young_purchase
	end

	test "should get create" do
		#Case NOT LOGGED IN
		post combo_purchases_path @combo
    assert_redirected_to login_url
		#Case FAILED VALIDATION
		log_in_as @young_client.account
		post combo_purchases_path @combo
		assert_template 'combos/show'
		assert_not flash[:danger].nil?
		#Case SUCCESS
		log_in_as @client.account
		post combo_purchases_path @combo
		follow_redirect!
		assert_not flash[:success].nil?
		assert_template "purchases/index"
	end

	test "should get destroy" do
		#Case NOT LOGGED IN
		delete purchase_path @purchase
    assert_redirected_to login_url
		#Case WRONG USER
		log_in_as @young_client.account
		delete purchase_path @purchase
		assert assert_redirected_to root_url
		assert_not flash[:danger].nil?
		#Case WRONG PURCHASE
		log_in_as @client.account
		delete purchase_path @other_purchase
		assert_redirected_to root_url
		assert_not flash[:danger].nil?
		#Case SUCCESS
		log_in_as @young_client.account
		delete purchase_path @other_purchase
		assert_redirected_to @other_purchase.buyer
		assert_not flash[:success].nil?
	end

	test "should get index" do
		#CASE NOT LOGGED IN
		get user_purchases_path @client
    assert_redirected_to login_url
		log_in_as @client.account
		#Case WRONG USER
		get user_purchases_path @young_client
		assert_redirected_to root_url
		assert_not flash[:danger].nil?
		#Case SUCCESS 
		get user_purchases_path @client
		assert_template "purchases/index"
	end

	test "should get show" do
		#Case NOT LOGGED IN
		get purchase_path @purchase
    assert_redirected_to login_url
		#Case WRONG USER
		log_in_as @young_client.account
		get purchase_path @purchase
		assert_redirected_to root_url
		assert_not flash[:danger].nil?
		#Case SUCCESS
		get purchase_path @other_purchase
		assert_template "purchases/show"
	end

end
