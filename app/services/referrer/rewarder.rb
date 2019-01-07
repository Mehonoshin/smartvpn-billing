# frozen_string_literal: true

module Referrer
  class Rewarder
    def self.add_funds(withdrawal, amount)
      rewarder = new(withdrawal, amount)
      rewarder.create_reward
    end

    def initialize(withdrawal, amount)
      @withdrawal = withdrawal
      @amount = amount
    end

    def create_reward
      if referrer? && @withdrawal.valid?
        Referrer::Reward.create!(
          referrer_id: referrer.id,
          amount: @amount,
          operation_id: @withdrawal.id
        )
      end
    end

    private

    def referrer
      @withdrawal.user.referrer
    end

    def referrer?
      referrer || nil
    end
  end
end
