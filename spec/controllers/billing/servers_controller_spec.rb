# frozen_string_literal: true

require 'spec_helper'

describe Billing::ServersController do
  subject { response }

  login_user

  describe 'GET #index' do
    before { get :index }

    it { should be_success }
    it { should render_template :index }
  end

  describe 'GET #download_config' do
    let!(:server) { create(:active_server) }

    before { server.plans << @user.plan }

    it 'calls config builder' do
      config = ServerConfigBuilder.new(server).generate_config
      ServerConfigBuilder.any_instance.expects(:generate_config).returns(config)
      get :download_config, id: server.id
    end

    it 'sends config to download' do
      get :download_config, id: server.id
      expect(response.header['Content-Type']).to eq 'application/octet-stream'
    end
  end
end
