require 'test_helper'

class AddingAndRemovingProducerOwnersTest < ActionDispatch::IntegrationTest
  
  def setup
  	@producer = producers :one
  	@account = accounts :one
  	@new_owner = accounts :two
  	@old_owner = accounts :owner_of_producer_one
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

  test "successfull new owner assigned and removed by admin" do
  	#Log as admin
  	log_in_as @account
  	#Assign new owner
  	get producer_path @producer
  	post producer_prod_owners_path(@producer), 
										params: { prod_owner: { account_id: @new_owner.id,
																						producer_id: @producer.id,
																						role: 'Manager' } }
		follow_redirect!
		assert_not flash.empty?
    assert_template 'producers/show'
		@producer.reload
		assert @producer.owners.include? @new_owner
		#Now remove him
		prod_owner = @producer.prod_owners.find_by account_id: @new_owner.id
		delete producer_prod_owner_path @producer, prod_owner
		follow_redirect!
		assert_not flash.empty?
    assert_template 'producers/show'
		@producer.reload
		assert_not @producer.owners.include? @new_owner
  end

  test "successfull new owner assigned and removed by other owner" do
  	#Log as old owner
  	log_in_as @old_owner
  	#Assign new owner
  	get producer_path @producer
  	post producer_prod_owners_path(@producer), 
										params: { prod_owner: { account_id: @new_owner.id,
																						producer_id: @producer.id,
																						role: 'Manager' } }
		follow_redirect!
		assert_not flash.empty?
    assert_template 'producers/show'
		@producer.reload
		assert @producer.owners.include? @new_owner
		#Now remove him
		prod_owner = @producer.prod_owners.find_by account_id: @new_owner.id
		delete producer_prod_owner_path @producer, prod_owner
		follow_redirect!
		assert_not flash.empty?
    assert_template 'producers/show'
		@producer.reload
		assert_not @producer.owners.include? @new_owner
  end

  test "owner edits his role" do
  	#Log as old owner
  	log_in_as @old_owner
  	#Assign new role
  	get producer_path @producer
  	new_role = "Big Boss"
  	prod_owner = @producer.prod_owners.find_by account_id: @old_owner.id
  	patch producer_prod_owner_path(@producer, prod_owner), 
										params: { prod_owner: { role: new_role } }
		follow_redirect!
		assert_not flash.empty?
    assert_template 'producers/show'
		prod_owner.reload
		assert_equal prod_owner.role, new_role
  end

end
