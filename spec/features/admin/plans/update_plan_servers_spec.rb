require 'spec_helper'

describe 'plan servers' do
  let!(:plan) { create(:plan) }
  let!(:server1) { create(:server) }
  let!(:server2) { create(:server) }

  it 'displays multiple servers select and updates plan' do
    sign_in_admin
    visit edit_admin_plan_path(plan)

    [server1.hostname, server2.hostname].each do |server_name|
      select(server_name, from: 'Servers')
    end

    click_button(I18n.t('global.apply'))
    visit admin_plans_path

    expect(plan.reload.servers).to eq [server1, server2]
  end
end
