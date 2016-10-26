class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
		def social_id_trimming
  		self.social_id.remove!(".") if not self.social_id.blank?
  	end
end
