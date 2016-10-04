class Account < ApplicationRecord
before_save :downcase_email

	has_one :user, inverse_of: :account, required: true

	accepts_nested_attributes_for :user

  validates :email, 	presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :password, 	presence: true, length: { minimum: 6, maximum: 12 }

  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_associated :user

  has_secure_password
private
	def downcase_email
		self.email.downcase! if not self.email.blank?
	end

end
