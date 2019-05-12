# frozen_string_literal: true

require 'rails_helper'

describe Billing::ServersController do
  subject { response }

  login_user

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end

  describe 'GET #download_config' do
    let!(:server) { create(:active_server, plans: [@user.plan]) }
    let!(:config) { ServerConfigBuilder.new(server: server).to_text }

    before { server.plans << @user.plan }

    it 'calls config builder' do
      allow_any_instance_of(ServerConfigBuilder).to receive(:to_text).and_return(config)
      get :download_config, params: { id: server.id }
    end

    it 'sends config to download' do
      get :download_config, params: { id: server.id }
      expect(response.header['Content-Type']).to eq 'application/octet-stream'
    end
  end
end
