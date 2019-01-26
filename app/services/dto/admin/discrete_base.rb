# frozen_string_literal: true

module Dto
  module Admin
    # This class replace nil value to zero for each dates and return statistics
    class DiscreteBase < Dto::Base
      def initialize(number_of_days:)
        @number_of_days = number_of_days
      end

      def amounts
        add_zero_amounts_for_dates
        values_by_days
      end

      private

      def add_zero_amounts_for_dates
        1.upto(@number_of_days) do |number|
          date = date_by_number_days_ago(number)
          values_by_days[date] = 0 if values_by_days[date].nil?
        end
      end

      def date_by_number_days_ago(number)
        number.day.ago.to_date
      end

      def values_by_days
        raise DtoException, 'Implement in a subclass'
      end
    end
  end
end
