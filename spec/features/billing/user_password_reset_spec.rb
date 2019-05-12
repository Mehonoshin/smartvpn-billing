# frozen_string_literal: true

require 'spec_helper'

describe 'Password reset' do
  subject { page }

  let!(:user) { create(:user) }

  it 'successful scenary' do
    ## Sign in page
    visit_sign_in_page
    expect(subject).to have_content I18n.t('users.sessions.new.forgotten_password')
    click_link I18n.t('users.sessions.new.forgotten_password')

    ## Reset page
    expect(subject).to have_selector 'form.reset-password'
    within('form') do
      fill_in 'user_email', with: user.email
    end
    click_button I18n.t('users.passwords.new.send')

    ## Final page
    expect(subject).to have_content I18n.t('devise.passwords.send_instructions')
    expect(last_email.body).to include user.email

    ## Follow email link
    token_name = 'reset_password_token'
    token_value = extract_token_from_email(token_name, last_email)
    visit("/users/password/edit?#{token_name}=#{token_value}")

    ## Edit password page
    expect(subject).to have_content I18n.t('users.passwords.edit.enter_new_password')

    within('form') do
      fill_in 'user_password', with: '1234567'
      fill_in 'user_password_confirmation', with: '1234567'
    end
    click_button I18n.t('users.passwords.edit.save')

    expect(subject).to have_content I18n.t('devise.passwords.updated')
  end
end
