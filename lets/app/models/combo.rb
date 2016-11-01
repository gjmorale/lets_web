class Combo < ApplicationRecord

	belongs_to :event
	has_many :offers, dependent: :destroy

	validates :name,		 			presence: true, length:{maximum: 50, minimum: 5}
	validates :description,	 	presence: true, length:{maximum: 250, minimum: 10}
	validates :min_age,		 		presence: true, :inclusion => 14..100, numericality: { only_integer: true }
	validates :max_age,		 		presence: true, :inclusion => 14..100, numericality: { only_integer: true }
	validates :gender,		 		presence: true, :inclusion => 0..2, numericality: { only_integer: true }
	validates :stock,		 			presence: true, :inclusion => 1..1000000, numericality: { only_integer: true }
  validates :buyable_from, 	presence: true
  validates :buyable_until, presence: true
  #E.G: validates_inclusion_of :birth_date, in: (100.years.ago)..(5.years.ago)

  validates_format_of :name, with: /\A[A-Za-z0-9\&\@\#\.\$]+([\!\?]{0,4}(\ |\,\ |\:\ )?[A-Za-z0-9\&\@\#\.\$]+)*[\!\?]{0,4}\z/i

end
