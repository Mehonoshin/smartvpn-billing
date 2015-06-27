require 'spec_helper'

describe 'Servers page' do
  let!(:plan) { create(:plan) }
  let!(:server) { create(:active_server) }
  let(:password) { 'password' }
  let!(:user) { create(:user, password: password, plan: plan) }
  let!(:not_available_server) { create(:active_server) }

  before do
    plan.servers << server
    sign_in(user, 'password')
  end

  it 'has servers list' do
    visit('/billing/servers')
    expect(page).to have_content server.hostname
    expect(page).to have_content server.protocol.upcase
    expect(page).to have_content server.port

    expect(page).not_to have_content not_available_server.hostname
  end
end
