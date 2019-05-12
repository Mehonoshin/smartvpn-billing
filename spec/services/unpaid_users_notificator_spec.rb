# frozen_string_literal: true

require 'spec_helper'

describe UnpaidUsersNotificator do
  subject { described_class.new }

  describe '#notify_all' do
    before do
      create_list(:user, 3, can_not_withdraw_counter: described_class::FAILED_WITHDRAWS)
      create(:user, can_not_withdraw_counter: described_class::FAILED_WITHDRAWS + 1)
      create(:user, can_not_withdraw_counter: described_class::FAILED_WITHDRAWS - 1)
      create(:user)
      user = create(:user_with_balance, can_not_withdraw_counter: described_class::FAILED_WITHDRAWS)
      create(:withdrawal, user: user)
    end

    it 'creates notification job for each unpaid user' do
      expect do
        subject.notify_all
      end.to change(UnpaidUserNotificationWorker.jobs, :count).by(3)
    end
  end
end
