class Level < ApplicationRecord
  belongs_to :producer
  has_many :guest_admissions, foreign_key: :guest_level_id, dependent: :nullify, class_name: 'Admission'
  has_many :actual_admissions, foreign_key: :actual_level_id, dependent: :nullify, class_name: 'Admission'
  has_many :required_products, foreign_key: :required_level_id, dependent: :nullify, class_name: 'Product'
  has_many :provided_products, foreign_key: :provided_level_id, dependent: :nullify, class_name: 'Product'

  validates :name, 			presence: true
	validates :order,			presence: true, :inclusion => 0..100, numericality: { only_integer: true }

	def Level.compare(low, high)
		return false if high.nil?
		return true if low.nil?
		high.order > low.order
	end
end
