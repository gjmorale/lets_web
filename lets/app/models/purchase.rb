class Purchase < ApplicationRecord
  belongs_to :offer, optional: true

  validates :price_paid,		presence: true, :inclusion => 0..1000000, numericality: { only_integer: true }
  validates :qr, 						presence: true, length: {is: 250}
  validates :status,				presence: true, :inclusion => 0..3, numericality: { only_integer: true }
  validates :date,						presence: true


	validates_format_of :qr, with: /\A[A-Za-z0-9]{250}\z/i

end
