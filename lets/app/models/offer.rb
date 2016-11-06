class Offer < ApplicationRecord
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
  end

  def required_level
    1
  end

  def provided_level
    2
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
      unless msg.emty?
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

end
