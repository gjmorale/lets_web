class Event < ApplicationRecord

	belongs_to :producer
  has_many :combos, dependent: :destroy
  has_many :admissions, dependent: :destroy
  has_many :users, through: :admissions

	validates :name,				presence: true, length:{maximum: 50, minimum: 5}
	validates :description,	presence: true, length:{maximum: 250, minimum: 10}
  validates :capacity, 		presence: true, :inclusion => 20..5000, numericality: { only_integer: true }
  validates :min_age, 		presence: true, :inclusion => 14..75, numericality: { only_integer: true }
  validates :max_age, 		presence: true, :inclusion => 18..100, numericality: { only_integer: true }
  validates :open_date,		presence: true
  validates :close_date,	presence: true
  validates :id,					uniqueness: {scope: :producer_id, message: "Event alreday belongs to producer"}

	validates_format_of :name, with: /\A[A-Za-z0-9]+(((\ \&|\.|\!{1,4})\ |[\ \-\_@\.\&]|\ \(|\()?[A-Za-z0-9]+\)?)*(\!{1,4}|\.?)\z/i
	
end
