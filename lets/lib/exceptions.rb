module Exceptions
	class ComboRestrictionsException < StandardError
    def initialize(data)
      @data = data
    end

    def message
    	@data
    end
  end
end