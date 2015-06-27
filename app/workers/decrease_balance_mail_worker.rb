class DecreaseBalanceMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(amount, user_id)
    user = User.find(user_id)
    UserMailer.balance_withdrawal(user, amount).deliver_now
  end
end
