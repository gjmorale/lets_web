class Producer < ApplicationRecord

	validates :name,			presence: true, length:{maximum: 250, minimum: 2}
	validates :fantasy_name,	presence: true, length:{maximum: 75, minimum: 3}
	validates :social_id,		presence: true, length:{maximum: 250, minimum: 2},	rut:true

  	validates_format_of :name, with: /\A[A-Za-z0-9]+([\ |\-|\_|\&|\.][A-Za-z0-9]+)*\.?\z/i
  	validates_format_of :fantasy_name, with: /\A[A-Za-z0-9]+([\ |\!|-|@|\.]{1,3}[A-Za-z0-9]+)*\.?\z/i
end
