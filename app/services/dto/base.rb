# frozen_string_literal: true

module Dto
  # This base class for Dto Admin dashboard
  class Base
    def initialize
      collect_data
    end

    private

    def collect_data
      raise DtoException, 'Implement in a subclass'
    end
  end
end
