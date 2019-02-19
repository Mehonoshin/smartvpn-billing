# frozen_string_literal: true

class Payment < ActiveRecord::Base
  include AASM
  include LastDaysFilterable

  belongs_to :user
  belongs_to :pay_system

  validates :user_id, :amount, presence: true

  before_create :convert_and_save_usd_amount

  scope :accepted, -> { where(state: 'accepted') }
  scope :in_current_month, -> { where(created_at: [Time.current.beginning_of_month..Time.current.end_of_month]) }

  aasm column: :state do
    state :pending, initial: true
    state :accepted

    event :accept do
      transitions from: :pending, to: :accepted, after: %i[increase_balance try_to_withdraw_funds]
    end
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
