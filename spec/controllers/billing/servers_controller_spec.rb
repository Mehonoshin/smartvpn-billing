# frozen_string_literal: true

require 'rails_helper'

describe Billing::ServersController do
  subject { response }

  login_user

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_success }
    it { is_expected.to render_template :index }
  end

  describe 'GET #download_config' do
    let!(:server) { create(:active_server, plans: [@user.plan]) }
    let!(:config) { ServerConfigBuilder.new(server: server).to_text }

    before { server.plans << @user.plan }

    it 'calls config builder' do
      ServerConfigBuilder.any_instance.expects(:to_text).returns(config)
      get :download_config, id: server.id
    end

    it 'sends config to download' do
      get :download_config, id: server.id
      expect(response.header['Content-Type']).to eq 'application/octet-stream'
    end
  end
end
