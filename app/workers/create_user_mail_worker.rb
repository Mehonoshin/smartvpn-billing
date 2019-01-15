# frozen_string_literal: true

class CreateUserMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailers

  def perform(user_params)
    user = User.find(user_params['user_id'])
    CreateUserMailer.notify(user: user, crypted_password: user_params['crypted_password']).deliver_now
  end
end
