require 'test_helper'

class ProdOwnerTest < ActiveSupport::TestCase
  def setup
  	@prod_owner = prod_owners :one
  end
end
