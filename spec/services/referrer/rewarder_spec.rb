# frozen_string_literal: true

require 'spec_helper'

describe Referrer::Rewarder do
  let(:amount) { 10 }
  let(:referrer) { create(:user) }

  before do
    withdrawal.user.update(referrer_id: referrer.id)
  end

  context 'withdrawal present' do
    let(:withdrawal) { create(:withdrawal) }

    it 'creates new reward' do
      expect do
        described_class.add_funds(withdrawal, amount)
      end.to change(Referrer::Reward, :count).by(1)
    end

    describe 'fields' do
      before do
        @reward = described_class.add_funds(withdrawal, amount)
      end

      it 'assigns amount to reward' do
        expect(@reward.amount).to eq amount
      end

      it 'assigns referrer_id' do
        expect(@reward.referrer_id).to eq referrer.id
      end

      it 'assigns operation_id' do
        expect(@reward.operation_id).to eq withdrawal.id
      end
    end
  end

  context 'withdrawal invalid' do
    let(:user) { create(:user) }
    let(:withdrawal) { Withdrawal.create(user: user, amount: 0) }

    it 'does not create reward' do
      expect do
        described_class.add_funds(withdrawal, amount)
      end.not_to change(Referrer::Reward, :count)
    end
  end
end
