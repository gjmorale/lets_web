require 'test_helper'

class AddingAndRemovingProducerOwnersTest < ActionDispatch::IntegrationTest
  
  def setup
  	@producer = producers :one
  	@account = accounts :one
  	@new_owner = accounts :two
  end

  test "non admin/owners can't assign owners" do
  	log_in_as @new_owner
  	get producer_path @producer
  	post producer_prod_owners_path(@producer), 
										params: { prod_owner: { account_id: @new_owner.id,
																						producer_id: @producer.id,
																						role: 'Manager' } }
		assert_not flash.empty?
		assert_redirected_to root_url
		@producer.reload
		assert_not @producer.owners.include? @new_owner
  end

  test "successfull new owner assigned by admin" do
  	log_in_as @account
  	get producer_path @producer
  	post producer_prod_owners_path(@producer), 
										params: { prod_owner: { account_id: @new_owner.id,
																						producer_id: @producer.id,
																						role: 'Manager' } }
		follow_redirect!
		assert_not flash.empty?
		#assert_redirected_to @producer
		@producer.reload
		assert @producer.owners.include? @new_owner
  end

end
