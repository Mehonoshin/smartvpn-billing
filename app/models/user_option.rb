# frozen_string_literal: true

class UserOption < ActiveRecord::Base
  # NOTICE:
  # bad name - UserOption.
  # better variant - OptionSubscription
  belongs_to :user
  belongs_to :option

  validates :user_id, :option_id, presence: true

  scope :enabled, -> { with_state(:enabled) }

  state_machine :state, initial: :enabled do
    event :enable do
      transition disabled: :enabled
    end

    event :disable do
      transition enabled: :disabled
    end
  end

  def toggle!
    enabled? ? disable! : enable!
  end
end
