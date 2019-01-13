# frozen_string_literal: true

class Payment < ActiveRecord::Base
  include LastDaysFilterable

  belongs_to :user
  belongs_to :pay_system

  validates :user_id, :amount, presence: true

  before_create :convert_and_save_usd_amount

  scope :accepted, -> { where(state: 'accepted') }

  state_machine :state, initial: :pending do
    event :accept do
      transition pending: :accepted
    end
    after_transition pending: :accepted, do: %i[increase_balance try_to_withdraw_funds]
  end

  private

  def convert_and_save_usd_amount
    return self.usd_amount = amount if pay_system.currency == 'usd'

    converter = Currencies::CourseConverter.new(currency_from: pay_system.currency, currency_to: 'usd', amount: amount)
    self.usd_amount = converter.convert_amount
  end

  def increase_balance
    user.increase_balance usd_amount
  end

  def try_to_withdraw_funds
    Withdrawer.single_withdraw(user)
  end
end

# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(, )
#  pay_system_id :integer
#  state         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  usd_amount    :decimal(12, 2)
#
