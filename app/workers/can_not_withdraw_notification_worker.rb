class CanNotWithdrawNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(user_id, amount)
    user = User.find(user_id)
    UserMailer.could_not_withdraw_funds(user, amount).deliver_now
  end
end
