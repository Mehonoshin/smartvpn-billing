# frozen_string_literal: true

class Option::ActivationPriceCalc
  class << self
    def activation_price(user, option)
      user.plan.option_price(option.code) * billing_interval_percent_left(user)
    end

    def billing_interval_percent_left(user)
      days_passed = (Time.current.to_date - user.last_withdrawal_date.to_date).to_i
      days_left = days_left_to_withdrawal(days_passed)
      (days_left.to_f / User::BILLING_INTERVAL.to_f)
    end

    def days_left_to_withdrawal(days_passed)
      if days_passed != User::BILLING_INTERVAL
        User::BILLING_INTERVAL - days_passed
      else
        30
      end
    end
  end
end
