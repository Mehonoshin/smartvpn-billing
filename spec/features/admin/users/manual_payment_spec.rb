# frozen_string_literal: true

require 'spec_helper'

describe 'manual user balance increase' do
  let!(:pay_system) { create(:pay_system) }
  let!(:user) { create(:user) }
  let(:amount) { 100 }
  let(:comment) { 'some comment' }

  it 'displays new payment form and increases balance' do
    sign_in_admin
    visit admin_user_path(user)

    expect(page).to have_content I18n.t('admin.users.new_payment')
    expect(page).to have_selector('form#new_payment')

    within('#new_payment') do
      fill_in 'payment_amount', with: amount
      fill_in 'payment_comment', with: comment
      click_button I18n.t('global.apply')
    end
    expect(page.find('.user_balance')).to have_content (amount - user.plan.price)
    expect(page).to have_content I18n.t('admin.users.notices.payment_created')
  end
end
