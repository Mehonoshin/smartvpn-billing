require 'spec_helper'

describe 'enabling options' do
  let!(:option) { create(:active_option) }
  let(:option_price) { 1 }
  let(:user) { User.last }
  let(:user_balance) { 100 }
  let(:pay_system) { create(:pay_system) }

  before do
    sign_in
    user.plan.options << option
    user.plan.update(option_prices: {option.code => option_price})
  end

  context 'user has withdrawal' do
    before do
      payment = user.payments.create(amount: user_balance, pay_system_id: pay_system.id)
      payment.accept!
    end

    it 'enables and disables option' do
      visit('/billing/options')
      expect(page).to have_content option.name

      click_button I18n.t('billing.options.activate')
      expect(page).to have_button I18n.t('billing.options.deactivate')

      visit('/billing')
      expect(page).to have_content "#{(user_balance - user.plan.price - option_price).to_i} USD"

      visit('/billing/options')
      click_button I18n.t('billing.options.deactivate')
      expect(page).to have_button I18n.t('billing.options.activate')
    end
  end

  context 'user does not have withdrawals' do
    it 'displays message on options page' do
      visit('/billing/options')
      expect(page).to have_content I18n.t('billing.options.notices.activate_subscription_first')
    end
  end
end
