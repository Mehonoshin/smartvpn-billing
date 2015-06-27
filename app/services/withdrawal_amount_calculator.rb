class WithdrawalAmountCalculator
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def amount_to_withdraw
    user.promotions.with_active_promos.inject(total_amount) do |amount, promotion|
      promotion.apply(amount)
    end
  end

  private

  def total_amount
    base_amount + options_amount
  end

  def base_amount
    user.plan.price
  end

  def options_amount
    user.options.active.reduce(0) do |sum, option|
      sum + user.plan.option_price(option.code)
    end
  end
end
