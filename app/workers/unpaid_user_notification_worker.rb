class UnpaidUserNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.unpaid_user_notification(user).deliver_now
  end
end
