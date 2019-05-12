# frozen_string_literal: true

require 'spec_helper'

describe 'referrers page', js: true do
  let(:referrer1) { create(:user) }
  let(:referrer2) { create(:user) }
  let(:referral1_email) { referrer1.referrals.first.email }
  let(:referral2_email) { referrer2.referrals.first.email }

  before do
    create_list(:user, 2, referrer: referrer1)
    create_list(:user, 3, referrer: referrer2)
    I18n.locale = :en
  end

  it 'toggles referrals on click on table line', disable_transaction: true do
    sign_in_admin
    visit admin_referrers_path

    # First referrer
    expect(page).not_to have_content referral1_email

    click_link referrer1.email
    find('.collapse.show')
    expect(page).to have_content referral1_email

    click_link referrer1.email
    find(:xpath, "//a[@href='#reffer-#{referrer1.id}']")
    expect(page).to have_no_text referral1_email

    # Second referrer
    expect(page).not_to have_content referral2_email

    click_link referrer2.email
    find('.collapse.show')
    expect(page).to have_content referral2_email

    click_link referrer2.email
    find(:xpath, "//a[@href='#reffer-#{referrer2.id}']")
    expect(page).not_to have_content referral2_email
  end
end
