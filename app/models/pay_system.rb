# frozen_string_literal: true

class PaySystem < ActiveRecord::Base
  include AASM

  CURRENCIES = %w[usd rub eur].freeze

  has_many :payments
  validates :name, :code, presence: true
  scope :enabled, -> { where(state: :enabled) }

  aasm column: :state do
    state :disabled, initial: true
    state :enabled

    event :enable do
      transitions from: :disabled, to: :enabled
    end

    event :disable do
      transitions from: :enabled, to: :disabled
    end
  end
end

# == Schema Information
#
# Table name: pay_systems
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  state       :string(255)
#  currency    :string(255)      default("usd")
#
