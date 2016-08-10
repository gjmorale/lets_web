class Product < ApplicationRecord

	validates :name,		 					presence: true, length:{maximum: 50, minimum: 5}
	validates :description,	 			presence: true, length:{maximum: 250, minimum: 10}
	validates :min_age,		 				presence: true, :inclusion => 14..100, numericality: { only_integer: true }
	validates :grants_admission,	presence: true, :inclusion => 0..1, numericality: { only_integer: true }
	validates :admission_level,		presence: true, :inclusion => 1..5, numericality: { only_integer: true }

  validates_format_of :name, with: /\A[A-Za-z0-9\&\@\#\.\$]+([\!\?]{0,4}(\ |\,\ |\:\ )?[A-Za-z0-9\&\@\#\.\$\-]+)*[\!\?]{0,4}\z/i
end
