# frozen_string_literal: true

module Dto
  module Admin
    class Dashboard < Dto::Base
      DISCRETE_DAYS_NUMBER = 12
      attr_accessor :income, :customers, :traffic, :courses

      def initialize(attributes = {})
        super
        collect_data
      end

      private

      def collect_data
        @income = {}
        @customers = {}
        @traffic = {}
        @courses = {}
        fetch_courses
        assign_statistics
        assign_discrete_statistics
      end

      def fetch_courses
        @courses[:rub_usd] = Currencies::Course.new('rub', 'usd').get.to_f
        @courses[:eur_usd] = Currencies::Course.new('eur', 'usd').get.to_f
        @courses[:updated_at] = Currencies::Course.updated_at.try(:to_datetime)
      end

      def assign_statistics
        @income[:total] = Payment.sum(:usd_amount)
        @customers[:total] = User.count
        @traffic[:total] = Disconnect.sum(:traffic_out)
      end

      def assign_discrete_statistics
        @income[:discrete] = discrete_payments.amounts.sort
        @traffic[:discrete] = discrete_traffic.amounts.sort.map { |date| [date[0], bytes_converter(date[1])] }
        @customers[:discrete] = discrete_customers.amounts.sort.map
      end

      def bytes_converter(value)
        BytesConverter.prettify_float(BytesConverter.bytes_to_gigabytes(value))
      end

      def discrete_payments
        @discrete_payments ||= Dto::Admin::DescretePayments.new(DISCRETE_DAYS_NUMBER)
      end

      def discrete_traffic
        @discrete_traffic ||= Dto::Admin::DescreteTraffic.new(DISCRETE_DAYS_NUMBER)
      end

      def discrete_customers
        @discrete_customers ||= Dto::Admin::DescreteCustomersRegistrations.new(DISCRETE_DAYS_NUMBER)
      end
    end
  end
end
