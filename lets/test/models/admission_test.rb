require 'test_helper'

class AdmissionTest < ActiveSupport::TestCase
  def setup
  	@admission = Admission.new(status: 1)
  end

  test "should be valid" do
  	assert @admission.valid?
  end

  test "status should be valid" do
  	@admission.status = -1
  	assert_not @admission.valid?, "Negative status should be invalid"
  	@admission.status = 6
  	assert_not @admission.valid?, "Status should be 5 or less"
  	@admission.status = 2
  	assert @admission.valid?, "Valid status should be accepted"
  end
end
