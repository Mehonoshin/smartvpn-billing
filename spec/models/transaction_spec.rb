# frozen_string_literal: true

require 'spec_helper'

describe Transaction do
  subject { described_class }

  let(:user) { create(:user, balance: 100) }

  describe '.user_transactions' do
    let(:payment) { create(:payment, created_at: 1.day.ago, user: user) }
    let(:withdrawal) { create(:withdrawal, created_at: 2.day.ago, user: user) }

    before do
      allow_any_instance_of(Payment).to receive(:try_to_withdraw_funds)
      payment.accept!
      withdrawal
      create(:withdrawal)
      create(:payment)
    end

    it 'returns user transactions list' do
      expect(subject.user_transactions(user).size).to eq 2
    end

    it 'returns only users transactions' do
      expect(subject.user_transactions(user).first.object).to eq payment
      expect(subject.user_transactions(user).last.object).to eq withdrawal
    end
  end

  describe '.all' do
    subject { described_class.all }

    let!(:transaction1) { create(:payment, created_at: 1.day.ago, state: 'accepted') }
    let!(:transaction2) { create(:payment, created_at: 3.day.ago, state: 'accepted') }
    let!(:transaction3) { create(:withdrawal, created_at: 4.day.ago) }
    let!(:transaction4) { create(:withdrawal, created_at: 2.day.ago) }

    it 'returns array' do
      expect(subject.class).to eq Array
    end

    it 'returns collection of payments and withdrawals' do
      expect(subject.count).to eq 4
    end

    it 'orders transactions on created_at value' do
      expect(subject.map { |t| t.created_at.to_i })
        .to eq [
          transaction1.created_at.to_i,
          transaction4.created_at.to_i,
          transaction2.created_at.to_i,
          transaction3.created_at.to_i
        ]
    end
  end

  describe 'numerates transactions' do
    subject { described_class.user_transactions(user) }

    let!(:other_transaction1) { create(:withdrawal) }
    let!(:other_transaction2) { create(:withdrawal) }
    let!(:user_transaction1) { create(:withdrawal, user: user) }
    let!(:user_transaction2) { create(:withdrawal, user: user) }

    it 'numerates transactions from 1 to N' do
      expect(subject.first.id).to eq 2
      expect(subject.last.id).to eq 1
    end
  end

  describe '#amount' do
    subject { described_class.new(1, object) }

    context 'payment transaction' do
      let(:object) { create(:payment) }

      it 'returns usd_amount of payment' do
        object.update(usd_amount: 123)
        expect(subject.amount).to eq 123
      end
    end

    context 'withdrawal transaction' do
      let(:object) { create(:withdrawal) }

      it 'returns amount of withdrawal' do
        expect(subject.amount).to eq object.amount
      end
    end
  end
end
