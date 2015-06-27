class NeverPaidUsersRansacker < BaseRansacker
  TRUE_VALUES = ['1', 1]

  def eq(value)
    if apply_ransacker?(value)
      table[:id].in(unpaid_user_ids)
    end
  end

  def unpaid_user_ids
    User.never_paid.map(&:id)
  end

  def apply_ransacker?(value)
    TRUE_VALUES.include?(value)
  end
end

