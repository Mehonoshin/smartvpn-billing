# frozen_string_literal: true

require 'spec_helper'

describe 'Plans option prices' do
  let!(:plan) { create(:plan) }
  let!(:option) { create(:option) }
  let!(:option_price) { '777' }

  before { I18n.locale = :ru }

  context 'option inactive' do
    it 'does now display option at select' do
      sign_in_admin
      visit edit_admin_plan_path(plan)
      expect(page).not_to have_content option.name
    end
  end

  context 'option is active' do
    it 'displays option price select and updates it' do
      option.activate!
      sign_in_admin
      visit edit_admin_plan_path(plan)

      expect(page).not_to have_content "#{option.name} price"

      select(option.name, from: 'Options')
      click_button(I18n.t('global.apply'))
      visit edit_admin_plan_path(plan)
      expect(page).to have_content "#{option.name} price"

      within('form.edit_plan') do
        fill_in "plan_option_prices_#{option.code}", with: option_price
        click_button I18n.t('global.apply')
      end

      visit edit_admin_plan_path(plan)
      expect(find("#plan_option_prices_#{option.code}").value).to eq option_price
    end
  end
end
