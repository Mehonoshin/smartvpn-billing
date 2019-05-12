# frozen_string_literal: true

require 'spec_helper'

describe Referrer::Account do
  subject { described_class.new(referrer.id) }

  let(:referrer) { create(:user) }
  let(:amounts) { [10, 20, 30] }

  before do
    amounts.each do |amount|
      create(:referrer_reward, referrer_id: referrer.id, amount: amount)
    end
  end

  describe '#balance' do
    it 'returns sum of all account operations' do
      expect(subject.balance).to eq amounts.inject(0) { |sum, a| sum + a }
    end
  end

  describe '#operations' do
    it 'returns all operations with referrer' do
      expect(subject.operations.count).to eq amounts.size
    end
  end

  describe '#referrals_total_amount' do
    let!(:referral) { create(:user_with_balance, referrer: referrer) }

    before do
      create_list(:withdrawal, 3, user: referral, amount: 3)
    end

    it 'returns sum of referrals withdrawals' do
      expect(subject.referrals_total_amount.to_f).to eq 9.0
    end
  end
end
