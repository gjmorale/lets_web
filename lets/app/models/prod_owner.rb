class ProdOwner < ApplicationRecord
  belongs_to :account
  belongs_to :producer

	validates_associated :user
	validates_associated :producer

	validates_uniqueness_of :user_id, scope: :producer_id
end
