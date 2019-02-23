# frozen_string_literal: true

require 'spec_helper'

describe 'User sign in' do
  before do
    sign_in
  end

  it 'displays user dashboard' do
    expect(page).to have_content I18n.t('billing.home.account_info.account_info')
  end
end
