class Event < ApplicationRecord

	validates :name,			presence: true, length:{maximum: 50, minimum: 5}
	validates :description,		presence: true, length:{maximum: 250, minimum: 10}
  validates :capacity, 		presence: true, :inclusion => 20..5000
  validates :min_age, 		presence: true, :inclusion => 14..75
  validates :max_age, 		presence: true, :inclusion => 18..100

	validates_format_of :name, with: /\A[A-Za-z0-9]+(((\ \&|\.|\!{1,4})\ |[\ \-\_@\.\&]|\ \(|\()?[A-Za-z0-9]+\)?)*(\!{1,4}|\.?)\z/i
	
end
