# frozen_string_literal: true

class UserOption < ActiveRecord::Base
  # NOTICE:
  # bad name - UserOption.
  # better variant - OptionSubscription
  include AASM

  belongs_to :user
  belongs_to :option

  validates :user_id, :option_id, presence: true

  aasm column: :state do
    state :enabled, initial: true
    state :disabled

    event :enable do
      transitions from: :disabled, to: :enabled
    end

    event :disable do
      transitions from: :enabled, to: :disabled
    end
  end

  def toggle!
    enabled? ? disable! : enable!
  end
end
