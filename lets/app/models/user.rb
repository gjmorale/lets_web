class User < ActiveRecord::Base
  before_save :capitalize_names
  before_validation :social_id_trimming

  has_one :account, inverse_of: :user, dependent: :destroy, autosave: true
  has_many :admissions, dependent: :destroy
  has_many :events, through: :admissions
  has_many :purchases, dependent: :destroy, foreign_key: :buyer_id

  validates :first_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :last_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :social_id, 	presence: true, length:{maximum:14, minimum:10},	rut: true, uniqueness: true
  validates :gender, 		presence: true, :inclusion => 0..1, numericality: { only_integer: true }
  validates :birth_date, 	presence: true
  validates_inclusion_of :birth_date, in: (100.years.ago)..(5.years.ago)
  
  validates_format_of :first_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i #Tildes...
  validates_format_of :last_name, with: /\A[A-Za-z]+(\ [A-Za-z]+)*\z/i

  def public_gender
    self.gender == 1 ? "Female" : "Male"
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def age
    now = DateTime.now
    age = now.year - self.birth_date.year
    age -= 1 if(now.yday < self.birth_date.yday)
    age
  end

  def toggle_admin toggle
    self.account.admin = toggle
    self.save
  end

  private

    def capitalize_names
      self.first_name.to_s.titleize
      self.last_name.to_s.titleize
    end

    #Inherits from ApplicationRecord but for some reason it doesn't pass tests
    def social_id_trimming
      self.social_id.remove!(".") if not self.social_id.blank?
    end

end
