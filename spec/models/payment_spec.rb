# frozen_string_literal: true

require 'spec_helper'

describe Payment do
  subject { build(:payment) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:amount) }

  it_behaves_like 'loads created by last days', :disconnect

  context 'on creation' do
    let(:pay_system) { create(:rub_pay_system) }
    let(:payment) { create(:payment, pay_system: pay_system, amount: 100) }
    let(:course) { 0.032 }

    before do
      allow_any_instance_of(Currencies::CourseConverter).to receive(:course).and_return(course)
    end

    it 'saves usd amount' do
      expect(payment.usd_amount).not_to be_nil
    end

    it 'converts rub by course' do
      expect(payment.usd_amount).to eq(payment.amount * course)
    end
  end

  context 'when created' do
    let(:user) { create(:user) }
    let(:pay_system) { create(:pay_system) }

    it 'is in peding state' do
      payment = described_class.create!(user_id: user.id, pay_system_id: pay_system.id, amount: 10)
      expect(payment.state).to eq 'pending'
    end
  end

  context 'on accept event' do
    before { allow_any_instance_of(Currencies::CourseConverter).to receive(:course).and_return(0.5) }

    describe 'balance increase' do
      let(:user) { create(:user_with_balance) }
      let(:pay_system) { create(:pay_system) }
      let!(:withdrawal) { create(:withdrawal, user: user) }
      let!(:payment) { create(:payment, user: user, pay_system: pay_system) }

      it 'changes user balance on amount' do
        initial_balance = user.reload.balance
        payment.accept!
        expect(user.reload.balance).to eq(initial_balance + payment.amount)
      end

      context 'pay system in non-usd' do
        let(:pay_system) { create(:rub_pay_system) }

        it 'adds usd_amount' do
          initial_balance = user.reload.balance
          payment.accept!
          expect(user.reload.balance).to eq(initial_balance + payment.usd_amount)
        end

        it 'does not add non-usd amount' do
          initial_balance = user.reload.balance
          payment.accept!
          expect(user.reload.balance).not_to eq(initial_balance + payment.amount)
        end
      end
    end

    describe 'balance withdrawal' do
      subject { create(:payment, user: user) }

      context 'user is unpaid' do
        let(:user) { create(:user_with_balance) }

        it 'creates new withdrawal' do
          expect { subject.accept! }.to change(Withdrawal, :count).by(1)
        end
      end

      context 'user is paid' do
        let(:user) { create(:user_with_balance) }

        before { create :withdrawal, user: user }

        it 'does not create withdrawal' do
          expect { subject.accept! }.not_to change(Withdrawal, :count)
        end
      end

      context 'user unpaid and has no balance,', focus: true do
        subject { create(:payment, amount: 5, user: user) }

        let(:user) { create(:user) }

        it 'does not create withdrawal' do
          expect { subject.accept! }.not_to change(Withdrawal, :count)
        end

        it 'sends notification' do
          expect { subject.accept! }.to change(CanNotWithdrawNotificationWorker.jobs, :size).by(1)
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(, )
#  pay_system_id :integer
#  state         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
