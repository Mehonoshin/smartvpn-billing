# frozen_string_literal: true

require 'spec_helper'

describe Withdrawer do
  subject { described_class }

  let!(:paid_client) { create :user_with_balance }
  let!(:new_client) { create :user_with_balance }
  let!(:non_paid_client) { create :user_with_balance }

  before do
    create :withdrawal, user: paid_client

    old_withdrawal = create :withdrawal, user: non_paid_client
    old_withdrawal.update(created_at: 2.month.ago)
  end

  describe '.mass_withdrawal' do
    let!(:non_paid_clients_number) { User.non_paid_users.size }

    it 'creates withdrawal for each non paid client' do
      expect do
        subject.mass_withdrawal
      end.to change(Withdrawal, :count).by(non_paid_clients_number)
    end
  end

  describe '.single_withdraw' do
    context 'user is unpaid' do
      context 'user has enough funds' do
        let!(:user) { create :user_with_balance }

        it 'creates withdraw' do
          expect do
            subject.single_withdraw(user)
          end.to change(Withdrawal, :count).by(1)
        end

        it 'gets withdrawal sum from calculator' do
          allow_any_instance_of(WithdrawalAmountCalculator).to receive(:amount_to_withdraw).and_return(10)
          subject.single_withdraw(user)
        end

        it 'tries to create withdrawal' do
          allow_any_instance_of(WithdrawalAmountCalculator).to receive(:add_funds_to_referrer)
          subject.single_withdraw(user)
        end

        context 'user has unsuccessfult attempts to withdraw funds' do
          before { user.update(can_not_withdraw_counter: 1) }

          it 'resets the counter' do
            expect do
              subject.single_withdraw(user)
            end.to change(user.reload, :can_not_withdraw_counter).to(0)
          end
        end
      end

      context 'user has not funds' do
        context 'first attempt to withdraw funds' do
          let(:user) { create :user }

          it 'notifies user by email' do
            expect do
              subject.single_withdraw(user)
            end.to change(CanNotWithdrawNotificationWorker.jobs, :size).by(1)
          end
        end

        context 'following attempt to withdraw' do
          let(:user) { create :user, can_not_withdraw_counter: 1 }

          it 'increments counter', disable_transaction: true do
            subject.single_withdraw(user)
            expect(user.reload.can_not_withdraw_counter).to eq 2
          end

          it 'does not send mail' do
            expect do
              subject.single_withdraw(user)
            end.not_to change(CanNotWithdrawNotificationWorker.jobs, :size)
          end
        end
      end
    end

    context 'user is paid' do
      let(:user) { create :user_with_balance }

      before { create(:withdrawal, user: user, plan: user.plan) }

      it 'does not create withdrawal' do
        expect do
          subject.single_withdraw(user)
        end.not_to change(Withdrawal, :count)
      end

      it 'does not notify user' do
        expect do
          subject.single_withdraw(user)
        end.not_to change(CanNotWithdrawNotificationWorker.jobs, :size)
      end
    end
  end
end
