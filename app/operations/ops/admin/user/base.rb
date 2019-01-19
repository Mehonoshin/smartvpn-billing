# frozen_string_literal: true

# This base class for user operations
module Ops
  module Admin
    module User
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
