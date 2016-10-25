class Producer < ApplicationRecord
  before_validation :social_id_trimming

  has_many :prod_owners
	has_many :admins, through: :prod_owners, source: :account

	validates :name,			presence: true, length:{maximum: 250, minimum: 2}
	validates :fantasy_name,	presence: true, length:{maximum: 75, minimum: 3}
	validates :social_id,		presence: true, length:{maximum: 250, minimum: 2},	rut:true, uniqueness: true

	validates_format_of :name, with: /\A[A-Za-z0-9]+(((\ \&|\.)\ |[\ \-\_\.\&])?[A-Za-z0-9]+)*\.?\z/i
	validates_format_of :fantasy_name, with: /\A[A-Za-z0-9]+(((\ \&|\.|\!{1,4})\ |[\ \-\_@\.\&])?[A-Za-z0-9]+)*(\!{1,4}|\.?)\z/i
	#[A-Za-z0-9]+(((\ \&|\.|\!{1,4})\ |[\ \-\_@\.\&]|\()?[A-Za-z0-9]+\)?)*(\!{1,4}|\.?) Option for parenthesis aproval

	private
		def social_id_trimming
  		self.social_id.remove!(".") if not self.social_id.blank?
  	end
end
