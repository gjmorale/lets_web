require 'test_helper'

class ProducerTest < ActiveSupport::TestCase
  def setup
  	@producer = Producer.new(name: "The big company LTDA.", fantasy_name: "Friends! Co.", social_id: "17.700.955-5")
  end

  test "should be valid" do
  	assert @producer.valid?	
  end

  test "name should be valid" do
  	@producer.name = "      "
  	assert_not @producer.valid?, "Can't be blank"
  	@producer.name = "a"*251
  	assert_not @producer.valid?, "Can't be longer than 250 characters"
  	@producer.name = "b"
  	assert_not @producer.valid?, "Can't be shorter than 2 characters"
  	@producer.name = "1-2_3 & 4 5"
  	assert @producer.valid?, "Can contain - _ & and whitespaces letters and numbers"
	@producer.name = '@%$#)()!°|'
  	assert_not @producer.valid?, "Can't contain any other character"
	@producer.name = "Jhonn  Red"
  	assert_not @producer.valid?, "Can't contain consecutive white spaces"
  end

  test "fantasy name should be valid" do
  	@producer.fantasy_name = "      "
  	assert_not @producer.valid?, "Can't be blank"
  	@producer.fantasy_name = "a"*76
  	assert_not @producer.valid?, "Can't be longer than 75 characters"
  	@producer.fantasy_name = "b"*2
  	assert_not @producer.valid?, "Can't be shorter than 3 characters"
  	@producer.fantasy_name = "1-2"
  	assert @producer.valid?, "Can contain - letters and numbers"
  	@producer.fantasy_name = "1_2"
  	assert @producer.valid?, "Can contain _ letters and numbers"
  	@producer.fantasy_name = "1 & 3"
  	assert @producer.valid?, "Can contain & letters and numbers"
  	@producer.fantasy_name = "1@2"
  	assert @producer.valid?, "Can contain @ letters and numbers"
  	@producer.fantasy_name = "1! 2"
  	assert @producer.valid?, "Can contain ! letters and numbers"
  	@producer.fantasy_name = "1 2"
  	assert @producer.valid?, "Can contain whitespaces letters and numbers"
	@producer.fantasy_name = '%$#)()°|'
  	assert_not @producer.valid?, "Can't contain any other character"
	@producer.fantasy_name = "Jhonn  Red"
  	assert_not @producer.valid?, "Can't contain consecutive white spaces"
  end

  test "social_id should be valid" do
  	@producer.social_id = "      "
  	assert_not @producer.valid?, "Rut can't be blank"
  	@producer.social_id = "17.700.800-1"
  	assert @producer.valid?, "Verifying digit must be valid"
  	@producer.social_id = "17700955-5"
  	assert @producer.valid?, "Without dots must be valid"
  	@producer.social_id = "11788935-5"
  	assert_not @producer.valid?, "Invalid verifying digits must be invalid"
  	@producer.social_id = "1a78j93@-5"
  	assert_not @producer.valid?, "Invalid characters must be invalid"
  end
end
