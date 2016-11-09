class Combo < ApplicationRecord
	require 'exceptions.rb'

	belongs_to :event
	has_many :offers, dependent: :destroy

	validates :name,		 			presence: true, length:{maximum: 50, minimum: 5}
	validates :description,	 	presence: true, length:{maximum: 250, minimum: 10}
	validates :min_age,		 		presence: true, :inclusion => 14..100, numericality: { only_integer: true }
	validates :max_age,		 		presence: true, :inclusion => 14..100, numericality: { only_integer: true }
	validates :gender,		 		presence: true, :inclusion => 0..2, numericality: { only_integer: true }
	validates :stock,		 			presence: true, :inclusion => 1..1000000, numericality: { only_integer: true }
  validates :buyable_from, 	presence: true
  validates :buyable_until, presence: true
  #E.G: validates_inclusion_of :birth_date, in: (100.years.ago)..(5.years.ago)

  validates_format_of :name, with: /\A[A-Za-z0-9\&\@\#\.\$]+([\!\?]{0,4}(\ |\,\ |\:\ )?[A-Za-z0-9\&\@\#\.\$]+)*[\!\?]{0,4}\z/i

  def price
  	total = 0
  	self.offers.each do |offer|
  		total += offer.price
  	end
  	return total
  end

  def buyable user
  	check user
  	@errors
  end

  def buying_errors
  	@errors
  end

  def buy user
  	ActiveRecord::Base.transaction do
	  	check! user
	  	set_exception "Requires higher level" if not check_levels user
			self.offers.each do |offer|
				offer.buy user
			end
			self.lock!
			if self.stock > 0
				self.stock -= 1
				self.save!
			else
				set_exception "This item is out of stock"
			end
		end
		true
	rescue Exceptions::ComboRestrictionsException => error
		#Debugging purposes only
		#puts "!!!--- #{error.message} ---!!!"
		false
  end

  def check_levels user
  	max_required = nil
  	admission = Admission.find_by(user: user, event: self.event)
  	max_provided = admission.access_level
  	self.offers.each do |offer|
  		provided_level = offer.provided_level
  		required_level = offer.required_level
  		max_required = required_level if Level.compare(max_required, required_level)
  		max_provided = provided_level if Level.compare(max_provided, provided_level)
  	end
  	not Level.compare(max_provided, max_required)
  end

  private

  	def check user
  		reset_errors
	  	set_error "This item is out of stock" unless stock_validation
	  	set_error "Item not available for #{user.public_gender.pluralize}" unless gender_validation user.gender
	  	set_error "Needs to be older than #{self.min_age} years old" unless min_age_validation user.age
	  	set_error "Needs to be younger than #{self.max_age} years old" unless max_age_validation user.age
	  	set_error "This item is not yet available" unless buyable_from_validation
	  	set_error "This item is no longer available" unless buyable_until_validation
	  	self.offers.each do |offer|
	  		errors = offer.buyable user 
	  		errors.each do |error|
	  			set_error error 
	  		end
	  	end
  	end

  	def check! user
	  	set_exception "This item is out of stock" unless stock_validation
	  	set_exception "Item not available for #{user.public_gender.pluralize}" unless gender_validation user.gender
	  	set_exception "Needs to be older than #{self.min_age} years old" unless min_age_validation user.age
	  	set_exception "Needs to be younger than #{self.max_age} years old" unless max_age_validation user.age
	  	set_exception "This item is not yet available" unless buyable_from_validation
	  	set_exception "This item is no longer available" unless buyable_until_validation
  	end

	  def set_error msg
	  	unless msg.empty?
	  		@errors << msg
	  	end
	  end

	  def set_exception msg
			raise Exceptions::ComboRestrictionsException.new(message: msg)
	  end

	  def reset_errors
	  	@errors = Array.new()
	  end

	  def stock_validation
	  	self.stock > 0
	  end

	  def gender_validation gender
	  	self.gender == 0 or self.gender == gender
	  end

	  def min_age_validation age
	  	self.min_age <= age
	  end

	  def max_age_validation age
	  	self.max_age >= age
	  end

	  def buyable_from_validation
	  	self.buyable_from <= DateTime.now
	  end

	  def buyable_until_validation
	  	self.buyable_until >= DateTime.now
	  end

end
