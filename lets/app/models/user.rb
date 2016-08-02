class User < ActiveRecord::Base

  validates :first_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :last_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :social_id, 	presence: true, length:{maximum:14, minimum:10},	rut: true
  validates :gender, 		presence: true, :inclusion => 0..1
  validates :birth_date, 	presence: true
  validates_inclusion_of :birth_date, in: (100.years.ago)..(5.years.ago)
  
  validates_format_of :first_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i
  validates_format_of :last_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i

end
