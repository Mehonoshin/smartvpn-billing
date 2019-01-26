# frozen_string_literal: true

module Dto
  module Admin
    class DiscreteCustomersRegistrations < Dto::Admin::DiscreteBase
      private

      def values_by_days
        @values_by_days ||= User
                            .in_days(@number_of_days)
                            .group('created_at::date')
                            .count
      end
    end
  end
end
