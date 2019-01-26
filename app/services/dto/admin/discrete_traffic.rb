# frozen_string_literal: true

module Dto
  module Admin
    class DiscreteTraffic < Dto::Admin::DiscreteBase
      private

      def values_by_days
        @values_by_days ||= Disconnect
                            .in_days(@number_of_days)
                            .group('created_at::date')
                            .sum(:traffic_in)
      end
    end
  end
end
