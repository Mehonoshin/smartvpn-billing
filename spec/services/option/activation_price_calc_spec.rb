# frozen_string_literal: true

require 'spec_helper'

describe Option::ActivationPriceCalc do
  subject { described_class.activation_price(user, option) }

  let!(:user) { create(:user_with_balance) }
  let!(:option) { create(:active_option) }
  let(:option_price) { 30 }

  before do
    user.plan.options << option
    user.plan.update(option_prices: { option.code => option_price })
    create(:withdrawal,
           plan: user.plan,
           user: user,
           amount: user.plan.price,
           created_at: last_withdrawal_days_ago.days.ago)
  end

  context 'last withdrawal was 15 days ago' do
    let(:last_withdrawal_days_ago) { 15 }

    describe '.activation_price' do
      it 'price is for 15 days' do
        expect(subject).to eq (option_price / 2)
      end
    end
  end

  context 'last withdrawal was 20 days ago' do
    let(:last_withdrawal_days_ago) { 20 }

    describe '.activation_price' do
      it 'price is for 15 days' do
        expect(subject).to eq (option_price / 3)
      end
    end
  end

  context 'last withdrawal was 0 days ago' do
    let(:last_withdrawal_days_ago) { 0 }

    describe '.activation_price' do
      it 'price is for 10 days' do
        expect(subject).to eq option_price
      end
    end
  end

  context 'last withdrawal was 30 days ago' do
    let(:last_withdrawal_days_ago) { 30 }

    describe '.activation_price' do
      it 'price is for 30 days' do
        expect(subject).to eq option_price
      end
    end
  end
end
