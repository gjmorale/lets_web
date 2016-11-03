require 'test_helper'

class EventOffersAComboTest < ActionDispatch::IntegrationTest
  
	def setup
		@admin = accounts :one
		@owner = accounts :owner_of_producer_one
		log_in_as @owner
		@producer = producers :one
		@event = events :one
		@new_combo = combos :two
		@new_offer = offers :two
		@new_product = products :two
		@old_combo = combos :one
		@old_offer = offers :one
		@old_product = products :one
	end

	def hashed_combo combo
		params = {params: {combo: {
			name: combo.name,
	    description: combo.description,
	    buyable_from: combo.buyable_from,
	    buyable_until: combo.buyable_until,
	    min_age: combo.min_age,
	    max_age: combo.max_age,
	    gender: combo.gender,
	    stock: combo.stock
			}}}
	end

	def hashed_offer offer
		params = {params: {offer: {
	    price: offer.price,
	    redeem_start: offer.redeem_start,
	    redeem_finish: offer.redeem_finish,
	    product_id: offer.product_id
	    }}}
	end

	def hashed_product product
		params = {params: {product: {
			name: product.name,
	    description: product.description,
	    min_age: product.min_age,
	    product_type: product.product_type
			}}}
	end

	test "should add product to event" do
		log_in_as @admin
		#Add product
		get products_path 
		assert_template 'products/index'
		assert_difference 'Product.count', 1 do
			post products_path, hashed_product(@new_product)
			follow_redirect!
			assert_template 'products/show'
		end
		product = Product.find_by name: @new_product.name
		assert_not product.nil?
		assert_equal @new_product.description, product.description 
		#Remove product
		assert_difference 'Product.count', -1 do
			delete product_path product
			follow_redirect!
			assert_template 'products/index'
		end
	end

	test "should add combo to event" do
		log_in_as @owner
		#Add combo
		get event_path @event
		assert_template 'events/show'
		assert_difference '@event.combos.count', 1 do
			post event_combos_path @event, hashed_combo(@new_combo)
			follow_redirect!
			assert_template 'events/show'
			@event.reload
		end
		combo = @event.combos.find_by name: @new_combo.name
		assert_not combo.nil?
		assert_equal @event.id, combo.event_id
		#Remove combo
		assert_difference '@event.combos.count', -1 do
			delete combo_path combo
			follow_redirect!
			assert_template 'events/show'
		end
	end

	test "should add offer to event" do
		log_in_as @owner
		old_combo = @event.combos.take
		assert_not old_combo.nil?
		#Add offer
		get event_path @event
		assert_template 'events/show'
		assert_difference 'old_combo.offers.count', 1 do
			post combo_offers_path old_combo, hashed_offer(@new_offer)
			follow_redirect!
			assert_template 'events/show'
			old_combo.reload
		end
		offer = old_combo.offers.find_by product_id: @new_offer.product_id
		assert_not offer.nil?
		assert_equal old_combo.id, offer.combo_id
		#Remove combo
		assert_difference 'old_combo.offers.count', -1 do
			delete offer_path offer
			follow_redirect!
			assert_template 'events/show'
		end
	end
	
end
