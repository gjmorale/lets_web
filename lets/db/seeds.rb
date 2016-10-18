# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

account = Account.new()
account.email = "mail@mail.com"
account.password = "123123"
account.password_confirmation = "123123"
account.admin = true
user = account.build_user
user.first_name  = 'Guillermo'
user.last_name  = 'Morales'
user.birth_date = Faker::Date.between(30.years.ago, 14.years.ago)
user.social_id = "17.700.955-5"
user.gender = 0
account.save

case Rails.env
when "development"
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
when "production"
  puts 'production'
end