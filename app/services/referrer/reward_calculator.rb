# frozen_string_literal: true

module Referrer
  class RewardCalculator
    def initialize(payment)
      @payment = payment
    end

    def amount
      @payment.amount * percent / 100
    end

    private

    def percent
      ENV['PARTNERS_REFERRER_PERCENT'].to_i
    end
  end
end
