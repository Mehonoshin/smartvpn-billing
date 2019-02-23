# frozen_string_literal: true

shared_examples 'creates payment for pay system' do |pay_system_code|
  describe 'new payment' do
    let!(:pay_system) { create(:enabled_pay_system, code: pay_system_code) }

    before do
      sign_in
      visit('/billing/payments')
      click_link pay_system.name
    end

    it 'has payment form' do
      expect(page).to have_selector 'form#new_payment'
    end

    context 'payment submitted' do
      before do
        click_button I18n.t('billing.payments.new.submit')
      end

      it 'finish payment page' do
        expect(page).to have_content I18n.t('billing.payments.merchant.payment_finalization')
      end
    end
  end
end
