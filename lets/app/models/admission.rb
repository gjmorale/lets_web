class Admission < ApplicationRecord
	belongs_to :event
	belongs_to :user

	validates :status,		 		presence: true, :inclusion => 0..5, numericality: { only_integer: true }

end
