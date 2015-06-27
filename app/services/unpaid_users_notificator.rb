class UnpaidUsersNotificator
  FAILED_WITHDRAWS = 3

  def notify_all
    users_to_notify.each do |user|
      notify(user)
    end
  end

  private

  def users_to_notify
    User.never_paid.where(can_not_withdraw_counter: FAILED_WITHDRAWS)
  end

  def notify(user)
    UnpaidUserNotificationWorker.perform_async(user.id)
  end
end
