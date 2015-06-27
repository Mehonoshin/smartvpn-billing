require 'spec_helper'

describe "test period applying" do
  let(:user) { User.last }

  before do
    sign_in
    visit('/billing')
  end

  it "test period in user dashboard" do
    expect(page).not_to have_content I18n.t('billing.home.account_info.test_period')

    user.test_period.enable!

    visit('/billing')
    expect(page).to have_content I18n.t('billing.home.account_info.test_period')
    expect(page).to have_content I18n.t('billing.home.account_info.test_period_range', from: human_date(user.test_period_started_at.to_date, time: false), to: human_date(user.test_period.test_period_until, time: false))
  end
end
