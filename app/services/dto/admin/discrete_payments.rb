# frozen_string_literal: true

module Dto
  module Admin
    class DiscretePayments < Dto::Admin::DiscreteBase
      private

      def values_by_days
        @values_by_days ||= Payment
                            .in_days(@number_of_days)
                            .group('created_at::date')
                            .sum(:amount)
      end
    end
  end
end
