# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@events = []

def generate_social_id
	length = 8
	number = Faker::Number.number(length)
	number_s = number.to_s
	total = 0
	length.times do |m|
		total += number_s[-(m+1)].to_i * (m%6 + 2)
	end
	resto = total % 11
	total = 11 - resto
	total = 'k' if total == 10
	total = '0' if total == 11
	return (number_s + '-' + total.to_s)
end

def generate_product(name, pre_1, ing_1, pre_2, ing_2, price)
	product = Product.new()
	product.name = "#{name} #{pre_1}"
	product.description = "#{name} con #{ing_1} y #{pre_2} #{ing_2}. Compra ahora y no te quedes sin!"
	product.min_age = 18
	product.product_type = 1
	return false unless product.save
	5.times do |n|
		bind_product product, price
	end
end

def generate_ticket(party, level, time, price)
	product = Product.new()
	product.name = "#{party} #{level}"
	product.description = "Entrada #{party} #{level} para ingresar hasta las #{time}. Recuerda entrar antes de la hora indicada."
	product.min_age = 18
	product.product_type = 1
	return false unless product.save
	6.times do |n|
		bind_product product, price
	end
end

def bind_product(product, price)
	event = @events[rand(0..@events.size-1)]
	puts "#{event.id} #{event.name}"
	combo = Combo.new()
	combo.event_id = event.id
	combo.name = product.name
	combo.description = product.description
	combo.buyable_from = Faker::Time.between(2.weeks.ago, event.open_date - 2.days)
	combo.buyable_until = Faker::Time.between(Date.today, event.close_date)
	combo.min_age = event.min_age
	combo.max_age = event.max_age
	combo.gender = 0
	combo.stock = 100
	combo.save
	unless combo.save
		puts 'Combo Errors:'
		combo.errors.full_messages.each do |msg|
			puts msg
		end
	end
	offer = Offer.new()
	offer.price = price
	offer.combo_id = combo.id
	offer.redeem_start = Faker::Time.between(event.open_date, event.close_date)
	offer.redeem_finish = Faker::Time.between(offer.redeem_start, event.close_date)
	offer.product_id = product.id
	unless offer.save
		puts 'Offer Errors:'
		offer.errors.full_messages.each do |msg|
			puts msg
		end
	end
end

account = Account.new()
account.email = "mail@mail.com"
account.password = "123123"
account.password_confirmation = "123123"
account.admin = true
user = account.build_user
user.first_name  = 'Guillermo'
user.last_name  = 'Morales'
user.birth_date = Faker::Date.between(26.years.ago, 24.years.ago)
user.social_id = "17.700.955-5"
user.gender = 0
account.save

producer = Producer.new()
producer.fantasy_name = "Productora LETS"
@fantasy_name = producer.fantasy_name
producer.name = "Productora LETS SpA"
producer.social_id = generate_social_id
producer.save
prod_owner = ProdOwner.new()
prod_owner.account_id = (Account.find_by email: "mail@mail.com").id
prod_owner.producer_id = producer.id
prod_owner.role = "Big Boss"
prod_owner.save

def populate
	total_saved = 0
	99.times do |n|
		account = Account.new()
		account.email = "example-#{n+1}@mail.org"
	  account.password = "password"
		account.password_confirmation = "password"
		user = account.build_user
	  user.first_name  = Faker::Name.first_name
	  user.last_name  = Faker::Name.last_name
	  user.birth_date = Faker::Date.between(30.years.ago, 14.years.ago)
		user.social_id = generate_social_id
	  user.gender = Faker::Number.between(0,1)
	  total_saved += 1 if account.save
	end
	puts("Total: " + total_saved.to_s)
	total_saved = 0

	producer = Producer.find_by fantasy_name: @fantasy_name
	7.times do |m|
		prod_owner = ProdOwner.new()
		prod_owner.account_id = (Account.find_by email: "example-#{40+m+1}@mail.org").id
		prod_owner.producer_id = producer.id
		prod_owner.role = "Sub-Manager"
		prod_owner.save
	end

	producers = []
	8.times do |n|
		producer = Producer.new()
		producer.fantasy_name = "Company #{n+1}"
		producer.name = "Company #{n+1} LTDA"
		producer.social_id = generate_social_id
		if producer.save
			producers << producer
			3.times do |m|
				prod_owner = ProdOwner.new()
				user = (Account.find_by email: "example-#{n*2+m+1}@mail.org")
				prod_owner.account_id = user.id if user
				prod_owner.producer_id = producer.id
				prod_owner.role = "Manager"
				unless prod_owner.save
					puts 'ProdOwner Errors:'
					prod_owner.errors.full_messages.each do |msg|
						puts msg
					end
				end
			end
			3.times do |m|
				event = Event.new()
				event.producer_id = producer.id
				event.name = "Evento #{m}#{producer.id}"
				event.description = "#{producer.name} te invita a la mejor fiesta de todas. Compra tu entrada y no te quedes fuera"
				event.capacity = 500
				event.min_age = 18
				event.max_age = 40
				event.open_date = Faker::Time.between(1.day.from_now, 2.weeks.from_now)
				event.close_date = event.open_date + 1.day
				unless event.save
					puts 'Event Errors:'
					event.errors.full_messages.each do |msg|
						puts msg
					end
				else 
					@events << event
				end
			end
		else
			puts 'Producer Errors:'
			producer.errors.full_messages.each do |msg|
				puts msg
			end
		end
	end

	generate_product("Piscola","Normal", "Coca-Cola", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Light", "Coca-Cola", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Zero", "Coca-Cola", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Normal", "Pepsi", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Light", "Pepsi", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Zero", "Pepsi", "pisco", "Mistral 35°", 3500)
	generate_product("Piscola","Normal", "Coca-Cola", "pisco", "Capel 35°", 3500)
	generate_product("Piscola","Light", "Coca-Cola", "pisco", "Capel 35°", 3500)
	generate_product("Piscola","Zero", "Coca-Cola", "pisco", "Capel 35°", 3500)
	generate_product("Piscola","Normal", "Pepsi", "pisco", "Capel 35°", 3500)
	generate_product("Piscola","Light", "Pepsi", "pisco", "Capel 35°", 3500)
	generate_product("Piscola","Zero", "Pepsi", "pisco", "Capel 35°", 3500)
	generate_product("Vodke","Normal", "Sprite", "vodka", "Eristoff 40°", 3500)
	generate_product("Vodke","Light", "Sprite", "vodka", "Eristoff 40°", 3500)
	generate_product("Vodke","Zero", "Sprite", "vodka", "Eristoff 40°", 4000)
	generate_product("Vodke","Normal", "Agua Tonica", "vodka", "Eristoff 40°", 4000)
	generate_product("Vodke","Light", "Agua Tonica", "vodka", "Eristoff 40°", 4000)
	generate_product("Vodke","Zero", "Agua Tonica", "vodka", "Eristoff 40°", 4000)
	generate_ticket("Miercoles PO!", "cortecía", "12:00", 2000)
	generate_ticket("Miercoles PO!", "normal", "02:00", 5000)
	generate_ticket("Miercoles PO!", "VIP", "02:00", 7000)
	generate_ticket("Miercoles PO!", "Mesa VIP", "01:00", 2000)
	generate_ticket("Preventa", "cortecía", "12:00", 0)
	generate_ticket("Preventa", "normal", "02:00", 2500)
	generate_ticket("Preventa", "VIP", "02:00", 3500)
	generate_ticket("Preventa", "Mesa VIP", "01:00", 0)
	
end

case Rails.env
when "development"
	populate
when "production"
  populate
end

