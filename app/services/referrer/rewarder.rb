module Referrer
  class Rewarder
    def self.add_funds(withdrawal, amount)
      rewarder = self.new(withdrawal, amount)
      rewarder.create_reward
    end

    def initialize(withdrawal, amount)
      @withdrawal, @amount = withdrawal, amount
    end

    def create_reward
      Referrer::Reward.create!(
        referrer_id: referrer.id,
        amount: @amount,
        operation_id: @withdrawal.id
      ) if referrer? && @withdrawal.valid?
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
