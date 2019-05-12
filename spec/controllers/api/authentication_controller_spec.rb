# frozen_string_literal: true

require 'spec_helper'

describe Api::AuthenticationController do
  it_behaves_like 'validating signature', :auth

  describe 'POST #auth' do
    let(:user) { create(:user_with_balance) }
    let(:server) { create(:server) }

    before do
      user.plan.servers << server
      allow_any_instance_of(described_class).to receive(:valid_api_call?).and_return(true)
    end

    context 'valid credentials' do
      let(:params) { Hash[login: user.vpn_login, password: user.vpn_password, hostname: server.hostname] }

      before { create(:withdrawal, user: user) }

      it 'returns 200 status' do
        post :auth, params: params
        expect(response.status).to eq 200
      end
    end

    context 'invalid credentials' do
      let(:params) { Hash[login: user.vpn_login, password: 'asd', hostname: server.hostname] }

      it 'returns 404 status' do
        post :auth, params: params
        expect(response.status).to eq 404
      end
    end
  end
end
