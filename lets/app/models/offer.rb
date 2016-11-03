class Offer < ApplicationRecord
  belongs_to :combo
  belongs_to :product
  has_many :purchases, dependent: :nullify

	validates :price,		 			presence: true, :inclusion => 0..1000000, numericality: { only_integer: true }
  validates :redeem_start, 	presence: true
  validates :redeem_finish, presence: true

end
