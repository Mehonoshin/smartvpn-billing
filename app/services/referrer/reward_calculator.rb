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
      Settings.partners.referrer_percent
    end
  end
end
