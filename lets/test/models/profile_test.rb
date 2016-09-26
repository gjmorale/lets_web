require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  
  def setup
  	@profile = Profile.new(name: "Un perfil", description: "Esta es la descripcion de un perfil")
  end

  test "name should be valid" do
  	@profile.name = "      "
  	assert_not @profile.valid?, "Can't be blank"
  	@profile.name = "a"*51
  	assert_not @profile.valid?, "Can't be longer than 50 characters"
  	@profile.name = "b"*4
  	assert_not @profile.valid?, "Can't be shorter than 5 characters"
  	@profile.name = "1-2_3 & 4 5 (6)" 
  	assert @profile.valid?, "Can contain - _ & ! () and whitespaces letters and numbers"
	  @profile.name = '@%$#!°|'
  	assert_not @profile.valid?, "Can't contain any other character"
	  @profile.name = "Jhonn  Red"
  	assert_not @profile.valid?, "Can't contain consecutive white spaces"
  end

  test "description should be valid" do
  	@profile.description = "      "
  	assert_not @profile.valid?, "Can't be blank"
  	@profile.description = "a"*251
  	assert_not @profile.valid?, "Can't be longer than 250 characters"
    @profile.description = "b"*9
    assert_not @profile.valid?, "Can't be shorter than 10 characters"
    @profile.description = "bkjnsdjvnskvnslnflanflkanflkn qkefnajknfsnfna kefjnakjf.1803rjj,sfn.mer.2388"
    assert @profile.valid?, "Valid descriptions must be accepted"
  end
end
