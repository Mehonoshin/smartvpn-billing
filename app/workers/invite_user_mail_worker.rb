# frozen_string_literal: true

class InviteUserMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailers

  def perform(user_id)
    user = User.find(user_id)
    InviteUserMailer.notify(user).deliver_now
  end
end
