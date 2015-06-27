class Option::Activator
  attr_accessor :user, :option

  def self.run(user, option_code)
    activator = self.new(user, option_code)
    activator.activate_option
  end

  def initialize(user, option_code)
    @option = user.plan.options.active.find_by(code: option_code)
    @user = user
  end

  def activate_option
    begin
      ActiveRecord::Base.transaction do
        withdraw_funds_for_option
        enable_option
        return true
      end
    rescue
      return false
    end
  end

  private

  def activation_price
    Option::ActivationPriceCalc.activation_price(user, option)
  end

  def enable_option
    raise 'Option not found' unless option
    user.user_options.create!(option: option, attrs: option.default_attributes)
  end

  def withdraw_funds_for_option
    user.withdrawals.create!(plan: user.plan, amount: activation_price)
  end
end
