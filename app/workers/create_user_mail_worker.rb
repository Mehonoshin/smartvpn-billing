# frozen_string_literal: true

class CreateUserMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailers

  def perform(user_id)
    user = User.find(user_id)
    UserConnectionConfigMailer.notify(user: user).deliver_now
  end
end
