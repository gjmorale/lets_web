class Profile < ApplicationRecord

	validates :name,				presence: true, length:{maximum: 50, minimum: 5}
	validates :description,	presence: true, length:{maximum: 250, minimum: 10}
  
	validates_format_of :name, with: /\A[A-Za-z0-9]+(((\ \&|\.|\!{1,4})\ |[\ \-\_@\.\&]|\ \(|\()?[A-Za-z0-9]+\)?)*(\!{1,4}|\.?)\z/i

end
