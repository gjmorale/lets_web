require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  def setup
    @client = users :client
    @young_client = users :young_client
    @old_client = users :old_client
  	@combo = combos :combo_of_eu
  end

  test "should be valid" do
  	assert @combo.valid?	
  end

  test "name should be valid" do
  	@combo.name = "       "
  	assert_not @combo.valid?, "Name can't be blank"
  	@combo.name = "a"*51
  	assert_not @combo.valid?, "Name can't be longer than 50 characters"
  	@combo.name = "b"*4
  	assert_not @combo.valid?, "Name can't be shorter than 5 characters"
  	@combo.name = "%/()="
  	assert_not @combo.valid?, "Name can't contain non alphanumerical characters except ! ? $ & . , : # @"
  	@combo.name = "El  Combo"
  	assert_not @combo.valid?, "Name can't contain consecutive whitespaces"
  	@combo.name = "El Combo: Lo Mejor!! para tod@s"
  	assert @combo.valid?, "Valid name should be accepted"
  end

  test "description should be valid" do 
  	@combo.description = "      "
  	assert_not @combo.valid?, "Description can't be blank"
  	@combo.description = "a"*251
  	assert_not @combo.valid?, "Description can't be longer than 250 characters"
  	@combo.description = "b"*9
  	assert_not @combo.valid?, "Description can't be shorter than 10 characters"
  	@combo.description = "Esta es una descripción válida."
  	assert @combo.valid?, "Valid descriptions must be accepted"
  end

  test "buyable_from date should be valid" do 
  	@combo.buyable_from = nil
  	assert_not @combo.valid?, "Null dates should not be accepted"
  	@combo.buyable_from = 1.months.ago
  	assert @combo.valid?, "Valid dates should be accepted"
  	@combo.buyable_from = "60-60-60"
  	assert_not @combo.valid?, "Invalid dates should not be accepted"
  end

  test "buyable_until date should be valid" do 
  	@combo.buyable_until = nil
  	assert_not @combo.valid?, "Null dates should not be accepted"
  	@combo.buyable_until = 1.months.from_now
  	assert @combo.valid?, "Valid dates should be accepted"
  	@combo.buyable_until = "60-60-60"
  	assert_not @combo.valid?, "Invalid dates should not be accepted"
  end

  test "min_age should be valid" do 
  	@combo.min_age = nil
  	assert_not @combo.valid?, "Null age should not be accepted"
  	@combo.min_age = 13
  	assert_not @combo.valid?, "Ages under 14 should not be accepted"
  	@combo.min_age = 101
  	assert_not @combo.valid?, "Ages over 100 should not be accepted"
  	@combo.min_age = 25
  	assert @combo.valid?, "Valid ages should be accepted"
  end

  test "max_age should be valid" do 
  	@combo.max_age = nil
  	assert_not @combo.valid?, "Null age should not be accepted"
  	@combo.max_age = 13
  	assert_not @combo.valid?, "Ages under 14 should not be accepted"
  	@combo.max_age = 101
  	assert_not @combo.valid?, "Ages over 100 should not be accepted"
  	@combo.max_age = 25
  	assert @combo.valid?, "Valid ages should be accepted"
  end

  test "gender should be valid" do 
  	@combo.gender = nil
  	assert_not @combo.valid?, "Gender can't be null"
  	@combo.gender = -1
  	assert_not @combo.valid?, "Gender can't be negative"
  	@combo.gender = 3
  	assert_not @combo.valid?, "Gender can't be greter than 2"
  	@combo.gender = 2
  	assert @combo.valid?, "Valid genders must be accepted"
  end

  test "stock should be valid" do 
  	@combo.stock = nil
  	assert_not @combo.valid?, "Stock can't be null"
    @combo.stock = 0
    assert_not @combo.valid?, "Stock can't be 0"
    @combo.stock = -1
    assert_not @combo.valid?, "Stock can't be negative"
  	@combo.stock = 1000001
  	assert_not @combo.valid?, "Stock can't be grater than 1.000.000"
  	@combo.stock = 10000
  	assert @combo.valid?, "Valid stocks must be accepted"
  end

  test "should check buyability" do
    assert_difference '@client.purchases.count', 2 do
      assert_difference '@combo.stock', -1 do
        assert @combo.buy @client
      end
    end
    assert_no_difference '@young_client.purchases.count' do
      assert_no_difference '@combo.stock' do
        assert_not @combo.buy @young_client
      end
    end
    assert_no_difference '@old_client.purchases.count' do
      assert_no_difference '@combo.stock' do
        assert_not @combo.buy @old_client
      end
    end
  end

end
