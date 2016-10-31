require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
  	@event = events :one
  end

  test "should be valid" do
  	assert @event.valid?	
  end

  test "name should be valid" do
  	@event.name = "      "
  	assert_not @event.valid?, "Can't be blank"
  	@event.name = "a"*51
  	assert_not @event.valid?, "Can't be longer than 50 characters"
  	@event.name = "b"*4
  	assert_not @event.valid?, "Can't be shorter than 5 characters"
  	@event.name = "1-2_3 & 4 5 (6)" 
  	assert @event.valid?, "Can contain - _ & ! () and whitespaces letters and numbers"
	  @event.name = '@%$#!°|'
  	assert_not @event.valid?, "Can't contain any other character"
	  @event.name = "Jhonn  Red"
  	assert_not @event.valid?, "Can't contain consecutive white spaces"
  end

  test "description should be valid" do
  	@event.description = "      "
  	assert_not @event.valid?, "Can't be blank"
  	@event.description = "a"*251
  	assert_not @event.valid?, "Can't be longer than 250 characters"
    @event.description = "b"*9
    assert_not @event.valid?, "Can't be shorter than 10 characters"
    @event.description = "bkjnsdjvnskvnslnflanflkanflkn qkefnajknfsnfna kefjnakjf.1803rjj,sfn.mer.2388"
    assert @event.valid?, "Valid descriptions must be accepted"
  end

  test "capacity should be valid" do
  	@event.capacity = 19
  	assert_not @event.valid?, "Capacity can't be lower than 20"
  	@event.capacity = 5001
  	assert_not @event.valid?, "Capacity can't be higher than 5000"
  	@event.capacity = -1
  	assert_not @event.valid?, "Capacity can't be negative"
  	@event.capacity = 500
  	assert @event.valid?, "Valid capacities must be accepted"
  end

  test "minimum age should be valid" do
  	@event.min_age = 13
  	assert_not @event.valid?, "Minimum age can't be lower than 14"
  	@event.min_age = 76
  	assert_not @event.valid?, "Minimum age can't be higher than 75"
  	@event.min_age = -1
  	assert_not @event.valid?, "Minimum age can't be negative"
  	@event.min_age = 20
  	assert @event.valid?, "Valid minimum age must be accepted"
  end

  test "maximum age should be valid" do
  	@event.max_age = 17
  	assert_not @event.valid?, "Maximum age can't be lower than 18"
  	@event.max_age = 101
  	assert_not @event.valid?, "Maximum age can't be higher than 100"
  	@event.max_age = -1
  	assert_not @event.valid?, "Maximum age can't be negative"
  	@event.max_age = 20
  	assert @event.valid?, "Valid maximum age must be accepted"
  end

  test "open_date should be valid" do 
    @event.open_date = nil
    assert_not @event.valid?, "Null is not a valid opening date" 
    @event.open_date = 1.week.from_now
    assert @event.valid?, "Valid opening dates must be accepted"
  end

  test "close_date should be valid" do 
    @event.close_date = nil
    assert_not @event.valid?, "Null is not a valid closing date" 
    @event.close_date = 1.week.from_now
    assert @event.valid?, "Valid closing dates must be accepted"
  end

end
