require 'spec_helper'

describe 'withdrawal prolongation' do
  let!(:user) { create(:user_with_balance) }

  context "user has withdrawal" do
    let!(:withdrawal) { create(:withdrawal, user: user) }
    let(:days_number) { 10 }

    it "displays form and changes next withdrawal date" do
      sign_in_admin
      visit admin_user_path(user)

      expect(page).to have_selector("form#new_withdrawal_prolongation")
      expect(page).to have_content(human_date DateTime.current)

      within('#new_withdrawal_prolongation') do
        fill_in 'withdrawal_prolongation_days_number', with: days_number
        click_button I18n.t('global.apply')
      end

      expect(page).to have_content(
        human_date(
          DateTime.current + (User::BILLING_INTERVAL + days_number).days
        )
      )
    end
  end

  context "users withdrawal has expired" do
    let(:days_number) { 10 }
    let!(:withdrawal) { create(:withdrawal, user: user, created_at: DateTime.new(2014, 03, 01)) }
    let!(:prolongation) { create(:withdrawal_prolongation, withdrawal: withdrawal, days_number: days_number) }

    it "displays as next withdrawal date billing interval + prolongation" do
      sign_in_admin
      visit admin_user_path(user)

      expect(page).not_to have_selector("form#new_withdrawal_prolongation")
      expect(page).to have_content I18n.t('admin.users.prolongation_not_possible')

      expect(page).to have_content(
        human_date(
          withdrawal.created_at + (User::BILLING_INTERVAL + days_number).days
        )
      )
    end

  end

  context "user does not have withdrawals" do
    it "does not show prolongation form" do
      sign_in_admin
      visit admin_user_path(user)

      expect(page).to have_content I18n.t('admin.users.prolongation_not_possible')
    end
  end
end
