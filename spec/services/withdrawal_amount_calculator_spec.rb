# frozen_string_literal: true

require 'spec_helper'

describe WithdrawalAmountCalculator do
  let(:user) { create(:user) }
  let(:calculator) { described_class.new(user) }

  describe 'intialization' do
    subject { calculator }

    it 'assigns user accessor' do
      expect(subject.user).to eq user
    end
  end

  describe '#amount_to_withdraw' do
    subject { calculator.amount_to_withdraw }

    it 'returns base plan price' do
      expect(subject).to eq user.plan.price
    end

    context 'promo exists' do
      let(:discount_promo) { create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now, attrs: { discount_percent: 30 }) }

      before do
        create(:promotion, user: user, promo: discount_promo)
        user.plan.update(price: 100)
      end

      it 'applyes promo to base amount' do
        expect(subject.to_f).to eq 70
      end

      context 'options exist' do
        let!(:option_one) { create(:active_option) }
        let!(:option_two) { create(:active_option) }

        before do
          prices = { option_one.code => 70, option_two.code => 30 }
          user.plan.update(option_prices: prices)

          user.plan.options << option_one
          user.plan.options << option_two

          user.options << option_one
          user.options << option_two
        end

        it 'applyes promo to total amount' do
          expect(subject).to eq 140
        end
      end

      context 'multiple promotions' do
        let(:second_discount_promo) { create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now, attrs: { discount_percent: 10 }) }

        before do
          create(:promotion, user: user, promo: second_discount_promo)
        end

        it 'applyes all promotions' do
          expect(subject.to_f).to eq 63
        end
      end
    end

    context 'no promos' do
      context 'options exist' do
        let(:user) { create(:user_with_balance) }
        let!(:option_one) { create(:active_option) }
        let!(:option_two) { create(:active_option) }

        before do
          prices = { option_one.code => 10, option_two.code => 15 }
          user.plan.update(option_prices: prices)

          user.plan.options << option_one
          user.plan.options << option_two

          user.options << option_one
          user.options << option_two
        end

        it 'adds option price to base plan price' do
          plan = user.plan
          expect(subject).to eq (plan.price + 25)
        end
      end
    end
  end
end
