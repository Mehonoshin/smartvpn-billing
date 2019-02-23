# frozen_string_literal: true

class NeverPaidUsersRansacker < BaseRansacker
  TRUE_VALUES = ['1', 1].freeze

  def eq(value)
    table[:id].in(unpaid_user_ids) if apply_ransacker?(value)
  end

  def unpaid_user_ids
    User.never_paid.map(&:id)
  end

  def apply_ransacker?(value)
    TRUE_VALUES.include?(value)
  end
end
