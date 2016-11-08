class Purchase < ApplicationRecord
	belongs_to :buyer, class_name: 'User'
  belongs_to :offer, optional: true

  validates :price_paid,		presence: true, :inclusion => 0..1000000, numericality: { only_integer: true }
  validates :qr, 						presence: true, length: {is: 250}
  validates :status,				presence: true, :inclusion => 0..3, numericality: { only_integer: true }
  validates :date,					presence: true


	validates_format_of :qr, with: /\A[A-Za-z0-9]{250}\z/i

	def Purchase.generate(user, offer)
		purchase = Purchase.new()
		purchase.buyer_id = user.id
		purchase.offer_id = offer.id
		purchase.price_paid = offer.price
		purchase.date = DateTime.now
		purchase.status = 0
		purchase.generate_qr
		purchase.save!
	end

	def generate_qr
		self.qr = 'A'*250
	end

	def reinburse
		#TODO: give back part of the money
	end

	private

end
