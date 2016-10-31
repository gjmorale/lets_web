require 'test_helper'

class ProdOwnersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@producer = producers :one
  	@owner = accounts :owner_of_producer_one
  	@not_owner = accounts :two
  	@prod_owner = prod_owners :one
  	@new_prod_owner = ProdOwner.new({account_id: @not_owner.id, role: "Manager"})
  end

  def hashed_prod_owner prod_owner
  	params = {params: {prod_owner: {
  		account_id: prod_owner.account_id,
  		role: prod_owner.role
		}}}
  end
  	
  test "should get create" do
    log_in_as @owner
    post producer_prod_owners_url @producer, hashed_prod_owner(@new_prod_owner)
    follow_redirect!
    assert_template "producers/show"
  end

  test "should get update" do
    log_in_as @owner
    @prod_owner.role = "New Role"
    patch prod_owner_url @prod_owner, hashed_prod_owner(@prod_owner)
    follow_redirect!
    assert_template "producers/show"
  end

  test "should get destroy" do
    log_in_as @owner
    delete prod_owner_url @prod_owner
    follow_redirect!
    assert_template "producers/show"
  end
end
