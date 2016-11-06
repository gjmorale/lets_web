module Exceptions
	class ComboRestrictionsException < StandardError
    def initialize(data)
      @data = data
    end
  end
end