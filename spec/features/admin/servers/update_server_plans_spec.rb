# frozen_string_literal: true

require 'spec_helper'

describe 'server plans' do
  let!(:plan1) { create(:plan, name: 'plan1') }
  let!(:plan2) { create(:plan, name: 'plan2') }
  let!(:server) { create(:server) }

  before { I18n.locale = :ru }

  it 'displays multiple plan select and updates server' do
    sign_in_admin
    visit edit_admin_server_path(server)

    [plan1.name, plan2.name].each do |plan_name|
      select(plan_name, from: 'Plans')
    end

    click_button(I18n.t('global.apply'))
    visit admin_servers_path

    expect(
      page
    ).to have_content "#{plan1.name}, #{plan2.name}"
  end
end
