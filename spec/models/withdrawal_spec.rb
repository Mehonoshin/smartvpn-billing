# frozen_string_literal: true

require 'spec_helper'

describe Withdrawal do
  subject { create(:withdrawal) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:plan_id) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:amount) }
end

describe Withdrawal, 'prolongation' do
  it { is_expected.to have_many :withdrawal_prolongations }

  describe '#prolongation_days' do
    subject { create(:withdrawal) }

    context 'prolongated' do
      before { create_list(:withdrawal_prolongation, 2, days_number: 1, withdrawal: subject) }

      it 'returns sum of prolongation days' do
        expect(subject.prolongation_days).to eq 2
      end
    end

    context 'no prolongation' do
      it 'returns zero' do
        expect(subject.prolongation_days).to eq 0
      end
    end
  end
end

describe Withdrawal, 'user balance decreases' do
  let(:user) { create(:user_with_balance) }
  let(:plan) { create(:plan) }
  let(:amount) { 1 }

  it 'decreases users balance on create' do
    balance_before = user.balance
    create(:withdrawal, user: user, plan: plan, amount: 1)
    expect(user.reload.balance).to eq(balance_before - amount)
  end

  context 'user has not enough funds' do
    let(:user) { create(:user) }

    it 'does not decrease balance' do
      expect { create(:withdrawal, user: user, plan: plan) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end

# == Schema Information
#
# Table name: withdrawals
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  user_id    :integer
#  plan_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
