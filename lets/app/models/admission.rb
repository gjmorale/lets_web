class Admission < ApplicationRecord

	validates :status,		 		presence: true, :inclusion => 0..5, numericality: { only_integer: true }

end
