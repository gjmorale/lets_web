class ProdOwner < ApplicationRecord
  belongs_to :account
  belongs_to :producer

	validates_associated :account
	validates_associated :producer

	validates_uniqueness_of :account_id, scope: :producer_id
end
