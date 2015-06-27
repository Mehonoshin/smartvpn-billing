module Referrer
  class Account
    def initialize(referrer_id)
      @referrer_id = referrer_id
      @referrer = User.find(referrer_id)
    end

    def balance
      operations.sum(:amount)
    end

    def operations
      Referrer::Reward.where(referrer_id: @referrer_id)
    end

    # Referrals payments sum
    def referrals_total_amount
      referral_ids = @referrer.referrals.map(&:id)
      Withdrawal.where(user_id: referral_ids).sum(:amount)
    end
  end
end
