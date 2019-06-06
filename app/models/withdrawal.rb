# frozen_string_literal: true

class Withdrawal < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  has_many :withdrawal_prolongations

  validates :amount, :user_id, :plan_id, presence: true
  validate :balance_greater_than_amount, on: :create, if: -> { 'user.present? && amount.present?' }

  after_create :decrease_user_balance

  scope :by_interval, ->(interval) { where('(DATE(?) - DATE(withdrawals.created_at)) < ?', Time.current, interval) }

  def prolongation_days
    withdrawal_prolongations.map(&:days_number).inject { |sum, n| sum + n } || 0
  end

  private

  def decrease_user_balance
    user.decrease_balance(amount)
  end

  def balance_greater_than_amount
    errors.add(:amount, I18n.t('activerecord.validations.withdrawal.not_enough_funds')) if user.balance < amount
  end
end

# == Schema Information
#
# Table name: withdrawals
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  user_id    :integer
#  plan_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
