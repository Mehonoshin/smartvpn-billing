# frozen_string_literal: true

class Withdrawer
  attr_accessor :withdrawal, :user

  class << self
    def mass_withdrawal
      withdrawer = new
      User.non_paid_users.each do |user|
        withdrawer.user = user
        withdrawer.try_to_withdraw
      end
    end

    def single_withdraw(user)
      withdrawer = new
      unless user.paid?
        # TODO: maybe move it to constructor?
        # self.new(user)
        withdrawer.user = user
        withdrawer.try_to_withdraw
      end
    end
  end

  def try_to_withdraw
    raise WithdrawerException, 'user not defined' if user.nil?

    withdraw_funds
    add_funds_to_referrer
    notify_user_if_needed
    increment_or_reset_counter
  end

  private

  def withdraw_funds
    calc = WithdrawalAmountCalculator.new(user)
    @withdrawal = user.reload.withdrawals.create(
      plan: user.plan,
      amount: calc.amount_to_withdraw
    )
  end

  def add_funds_to_referrer
    reward_amount = Referrer::RewardCalculator.new(@withdrawal).amount
    Referrer::Rewarder.add_funds(@withdrawal, reward_amount)
  end

  def increment_or_reset_counter
    if can_not_withdraw
      user.class.where(id: user.id).update_all(['can_not_withdraw_counter = can_not_withdraw_counter + ?', 1])
    else
      user.update(can_not_withdraw_counter: 0)
    end
  end

  def notify_user_if_needed
    if can_not_withdraw && first_notification?
      CanNotWithdrawNotificationWorker.perform_async(user.id, user.plan.price)
    end
  end

  def can_not_withdraw
    !@withdrawal.valid?
  end

  def successful_withdrawal?
    @withdrawal.valid?
  end

  def first_notification?
    user.can_not_withdraw_counter.zero?
  end
end
