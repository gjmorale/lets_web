require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  def setup
  	@club = Club.new(name: "La Disco!", address: "Av. Siempre viva 123", capacity: 600)
  end

  test "address should be valid" do
  	@club.address = "       "
  	assert_not @club.valid?, "Address can't be blank"
  	@club.address = "a"*101
  	assert_not @club.valid?, "Address can't be longer than 100 characters"
  	@club.address = "b"*9
  	assert_not @club.valid?, "Address can't be shorter than 10 characters"
  	@club.address = "°!!$%&/()=?"
  	assert_not @club.valid?, "Address can't contain non alphanumerical characters except dots # and colons"
  	@club.address = "Siempre  viva"
  	assert_not @club.valid?, "Address can't contain consecutive whitespaces"
  	@club.address = 'Av. Siempre viva #123, Chile'
  	assert @club.valid?, "Valid addresses should be accepted"
  end

  test "name should be valid" do
  	@club.name = "        "
  	assert_not @club.valid?, "Name can't be blank"
  	@club.name = "a"*51
  	assert_not @club.valid?, "Name can't be longer than 50 characters"
  	@club.name = "b"*2
  	assert_not @club.valid?, "Name can't be shorter than 3 characters"
  	@club.name = "%/()="
  	assert_not @club.valid?, "Name can't contain non alphanumerical characters except ! ? $ & . , : # @"
  	@club.name = "El  Club"
  	assert_not @club.valid?, "Name can't contain consecutive whitespaces"
  	@club.name = "El Club: Lo Mejor!! para tod@s"
  	assert @club.valid?, "Valid name should be accepted"
  end

  test "capacity should be valid" do
  	@club.capacity = 49
  	assert_not @club.valid?, "Capacity can't be lower than 50"
  	@club.capacity = 100001
  	assert_not @club.valid?, "Capacity can't be higher than 100.000"
  	@club.capacity = -1
  	assert_not @club.valid?, "Capacity can't be negative"
  	@club.capacity = 25683
  	assert @club.valid?, "Valid capacity should be valid"
  end

end
