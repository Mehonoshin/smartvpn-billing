# frozen_string_literal: true

module Dto
  module Admin
    # This class collect statistic about traffic, income amount, customers
    class Dashboard < Dto::Base
      DISCRETE_DAYS_NUMBER = 12
      attr_reader :income, :customers, :traffic, :courses

      private

      def collect_data
        @courses = fetch_courses
        @income = fetch_income
        @customers = fetch_customers
        @traffic = fetch_traffic
      end

      def fetch_courses
        {
          rub_usd: fetch_course(:rub, :usd),
          eur_usd: fetch_course(:eur, :usd),
          updated_at: course_updated_at
        }
      end

      def fetch_income
        {
          total: Payment.sum(:usd_amount),
          discrete: discrete_payments.amounts.sort
        }
      end

      def fetch_customers
        {
          total: User.count,
          discrete: discrete_customers.amounts.sort.map
        }
      end

      def fetch_traffic
        {
          total: Disconnect.sum(:traffic_out),
          discrete: converted_discrete_traffic
        }
      end

      def fetch_course(from_currency, for_currency)
        Currencies::Course.new(from_currency, for_currency).get.to_f
      end

      def course_updated_at
        Currencies::Course.updated_at.try(:to_datetime)
      end

      def converted_discrete_traffic
        discrete_traffic
          .amounts
          .sort
          .map { |date| [date[0], bytes_converter(date[1])] }
      end

      def bytes_converter(value)
        BytesConverter.prettify_float(BytesConverter.bytes_to_gigabytes(value))
      end

      def discrete_payments
        @discrete_payments ||= Dto::Admin::DiscretePayments.new(number_of_days: DISCRETE_DAYS_NUMBER)
      end

      def discrete_traffic
        @discrete_traffic ||= Dto::Admin::DiscreteTraffic.new(number_of_days: DISCRETE_DAYS_NUMBER)
      end

      def discrete_customers
        @discrete_customers ||= Dto::Admin::DiscreteCustomersRegistrations.new(number_of_days: DISCRETE_DAYS_NUMBER)
      end
    end
  end
end
