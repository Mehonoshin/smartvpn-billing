# frozen_string_literal: true

class WithdrawalsWorker
  include Sidekiq::Worker

  def perform
    Withdrawer.mass_withdrawal
    UnpaidUsersNotificator.new.notify_all
  end
end
