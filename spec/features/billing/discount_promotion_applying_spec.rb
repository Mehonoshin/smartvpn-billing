# frozen_string_literal: true

require 'spec_helper'

describe '30% discount applying' do
  let(:promo_code) { 'super-code' }
  let(:pay_system) { create(:pay_system) }
  let(:user) { User.last }
  let!(:plan) { create(:plan, price: 100) }
  let!(:promo) do
    create(:promo, promo_code: promo_code,
                   date_from: 1.week.ago, date_to: 1.week.from_now,
                   attrs: { discount_percent: 30 },
                   state: 'active')
  end

  before do
    sign_in
    visit('/users/edit')
  end

  it 'enters promo-code and has 30% discount' do
    user.update(plan_id: plan.id)

    within('#new_promotion') do
      fill_in 'promotion_promo_code', with: promo_code
      click_button I18n.t('global.apply')
    end
    expect(page).to have_content I18n.t('billing.promotions.notices.promotion_activated')

    payment = user.payments.create!(amount: 300, pay_system: pay_system)
    payment.accept!

    visit('/billing')
    expect(page).to have_content '-70 USD'
    expect(page).to have_content '230 USD'
  end
end
