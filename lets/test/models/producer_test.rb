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
  	@producer.name = "1-2_3&4 5"
  	assert @producer.valid?, "Can contain - _ & and whitespaces letters and numbers"
	@producer.name = '@%$#)()!°|'
  	assert_not @producer.valid?, "Can't contain any other character"
	@producer.name = "Jhonn  Red"
  	assert_not @producer.valid?, "Can't contain consecutive white spaces"
  end
end
