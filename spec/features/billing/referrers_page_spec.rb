# frozen_string_literal: true

require 'spec_helper'

describe 'Partner programm' do
  let(:password) { '12345678' }
  let!(:referrer) { create(:user, password: password) }

  describe 'referrers statistics' do
    before do
      sign_in referrer, password
    end

    context 'has no referrers and rewards' do
      it 'displays message' do
        visit('/billing/referrers')
        expect(page).to have_content I18n.t('billing.referrals.no_referrals')
        expect(page).to have_content I18n.t('billing.referrals.no_operations')
        expect(page).to have_content '0.0 $'
      end
    end

    context 'referrer exists' do
      let(:referral) { create(:user_with_balance) }

      before do
        referrer.referrals << referral
        operation = Withdrawal.create!(amount: 10, plan: Plan.first, user: referral)
        Referrer::Reward.create!(amount: 1, operation_id: operation.id, referrer_id: referrer.id)
      end

      it 'has statistics data' do
        visit('/billing/referrers')
        expect(page).to have_content referral.email
        expect(page).to have_content '1.0 $'
      end
    end
  end

  describe 'referral registration process' do
    let(:email) { 'user@email.com' }
    let(:reflink) { referrer.reflink }

    before do
      create(:plan)
    end

    it 'successful scenary' do
      visit("/referrer?code=#{reflink}")

      visit('/users/sign_up')
      within('#new_user') do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password
        check 'user_accept_agreement'
      end
      click_button I18n.t('users.registrations.new.sign_up')

      sign_in referrer, password
      visit('/billing/referrers')
      expect(page).to have_content email
    end
  end
end
