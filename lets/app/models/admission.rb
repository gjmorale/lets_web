class Admission < ApplicationRecord
	belongs_to :event
	belongs_to :user
	belongs_to :actual_level, class_name: 'Level', optional: true
	belongs_to :guest_level, class_name: 'Level', optional: true

	validates :status,		 		presence: true, :inclusion => 0..5, numericality: { only_integer: true }

	def access_level
		Level.compare(self.actual_level, self.guest_level) ? self.guest_level : self.actual_level
	end

	def Admission.get_or_new(user, event)
    admission = Admission.new(user: user, event: event) unless admission = Admission.where(user: user, event: event).take
    admission
	end

end
