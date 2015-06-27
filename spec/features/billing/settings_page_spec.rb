require 'spec_helper'

describe 'Settings page' do
  let!(:plan) { create(:plan) }
  let!(:server) { create(:active_server) }
  let(:password) { 'password' }
  let!(:user) { create(:user, password: password, plan: plan) }

  before do
    plan.servers << server
    sign_in(user, 'password')
    visit('/users/edit')
  end

  it 'has servers list, edit profile form, remove profile link' do
    expect(page).to have_content I18n.t('users.registrations.edit.edit_profile')
  end

  it 'removing registration' do
    expect(page).to have_content I18n.t('users.registrations.edit.cancel_registration')
    click_button I18n.t('users.registrations.edit.cancel_registration')
    expect(page).to have_content I18n.t('devise.registrations.destroyed')
  end
end
