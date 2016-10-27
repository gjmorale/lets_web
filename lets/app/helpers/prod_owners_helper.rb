module ProdOwnersHelper

	def is_owner?(producer)
		producer.nil? ? false : producer.owners.include?(current_account) 
	end
end
