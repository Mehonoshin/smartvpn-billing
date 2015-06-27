class IncreaseBalanceMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(amount, user_id)
    user = User.find(user_id)
    UserMailer.funds_recieved(user, amount).deliver_now
  end
end
