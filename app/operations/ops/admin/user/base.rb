# frozen_string_literal: true

module Ops
  module Admin
    module User
      # This base class for user operations
      class Base
        attr_reader :params

        def initialize(params:)
          @params = params
        end

        def call
          raise NotImplementedError
        end
      end
    end
  end
end
