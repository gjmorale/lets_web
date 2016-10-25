class Account < ApplicationRecord
attr_accessor :remember_token
before_save :downcase_email

belongs_to :user, inverse_of: :account, required: true, dependent: :destroy, autosave: true
has_many :prod_owners
has_many :producers, through: :prod_owners

accepts_nested_attributes_for :user

validates :email, 	presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
validates :password, 	presence: true, length: { minimum: 6, maximum: 12 }

validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates_associated :user

has_secure_password

def remember
  self.remember_token = Account.new_token
  update_attribute(:remember_digest, Account.digest(remember_token))
end

def forget
  update_attribute(:remember_digest, nil)
end

def authenticated?(remember_token)
	remember_digest.nil? ? false : BCrypt::Password.new(remember_digest).is_password?(remember_token)
end

#Move later to use across models
def Account.digest(string)
	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

# Returns a random token.
def Account.new_token
  SecureRandom.urlsafe_base64
end

private
	def downcase_email
		self.email.downcase! if not self.email.blank?
	end

end
