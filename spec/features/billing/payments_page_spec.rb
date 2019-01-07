# frozen_string_literal: true

require 'spec_helper'

describe 'Payments page' do
  it_behaves_like 'creates payment for pay system', 'wmz'
  it_behaves_like 'creates payment for pay system', 'wmr'
  it_behaves_like 'creates payment for pay system', 'yandex'

  describe 'pay systems list' do
    let!(:disabled_pay_system) { create(:pay_system) }
    let!(:enabled_pay_system) { create(:enabled_pay_system) }

    before do
      sign_in
      visit('/billing/payments')
    end

    it 'has pay systems list' do
      expect(page).to have_link enabled_pay_system.name
    end

    it 'does not display link to disabled pay system' do
      expect(page).not_to have_link disabled_pay_system.name
    end
  end

  describe 'payment amount page' do
    let(:code) { pay_system.code }
    let(:new_payment_page_path) { "/billing/payments/new?code=#{code}" }

    before { sign_in }

    context 'usd pay system' do
      let(:pay_system) { create(:enabled_pay_system) }

      it 'contains plan price in dollars' do
        visit(new_payment_page_path)
        expect(page).to have_selector("input[value='#{@user.plan.price.to_i}']")
      end
    end

    context 'rub paysystem' do
      let(:pay_system) { create(:rub_pay_system) }
      let(:amount)     { 650 }

      it 'contains price in rubles' do
        Currencies::CourseConverter.any_instance.expects(:convert_amount).returns(amount)
        visit(new_payment_page_path)
        expect(page).to have_selector("input[value='#{amount}']")
      end
    end
  end
end
