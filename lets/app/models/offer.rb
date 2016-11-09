class Offer < ApplicationRecord
  before_create :validate_product

  belongs_to :combo
  belongs_to :product
  has_many :purchases, dependent: :nullify

	validates :price,		 			presence: true, :inclusion => 0..1000000, numericality: { only_integer: true }
  validates :redeem_start, 	presence: true
  validates :redeem_finish, presence: true

  def buyable user
  	check user
    @errors
  end

  def buy user
    check! user
    Purchase.generate(user, self)
    event = self.combo.event
    admission = Admission.new(user: user, event: event) unless admission = Admission.where(user: user, event: event).take
    admission.actual_level = provided_level if Level.compare(admission.actual_level, provided_level)
    admission.save!
  end

  def required_level
    product.required_level
  end

  def provided_level
    product.provided_level
  end

  private

    def check user
      reset_errors
      set_error "This item is no longer available" unless redeem_finish_validation
      set_error "Needs to be older than #{self.min_age} years old" unless min_age_validation user.age
    end

    def check! user
      set_exception "This item is no longer available" unless redeem_finish_validation
      set_exception "Needs to be older than #{self.min_age} years old" unless min_age_validation user.age
    end

    def set_error msg
      unless msg.empty?
        @errors << msg
      end
    end

    def set_exception msg
      raise Exceptions::OfferRestrictionsException.new(message: msg)
    end

    def reset_errors
      @errors = Array.new()
    end

    def redeem_finish_validation
      self.redeem_finish > DateTime.now
    end

    def min_age_validation age
      self.product.min_age <= age
    end

    def validate_product
      errors.add(:product_id, :blank, message: "Must have a product") if self.product_id.nil?
    end

end
