class User < ActiveRecord::Base

  belongs_to :account, inverse_of: :user

	before_validation :social_id_trimming

  validates :first_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :last_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :social_id, 	presence: true, length:{maximum:14, minimum:10},	rut: true, uniqueness: true
  validates :gender, 		presence: true, :inclusion => 0..1, numericality: { only_integer: true }
  validates :birth_date, 	presence: true
  validates_inclusion_of :birth_date, in: (100.years.ago)..(5.years.ago)
  
  validates_format_of :first_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i #Tildes...
  validates_format_of :last_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i

  private
  	def social_id_trimming
  		self.social_id.remove!(".") if not self.social_id.blank?
  	end

end
