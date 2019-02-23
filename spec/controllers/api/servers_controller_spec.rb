# frozen_string_literal: true

require 'spec_helper'

describe Api::ServersController do
  let!(:server) { create(:server) }

  describe 'POST #activate' do
    let(:params) do
      {
        secret_token: secret_token,
        hostname: hostname,
        server_crt: 'server crt',
        client_crt: 'client crt',
        client_key: 'client key'
      }
    end

    context 'hostname not present in DB' do
      let(:hostname) { 'incorrect.domain' }
      let(:secret_token) { Settings.secret_token }

      it 'raises error' do
        expect do
          post :activate, params
        end.to raise_error ApiException, 'Server for activation not found'
      end
    end

    describe 'secret token validation' do
      let(:hostname) { server.hostname }

      context 'correct token' do
        let(:secret_token) { Settings.secret_token }

        it 'renders json with auth key' do
          post :activate, params
          expect(response.body).to eq Hash[auth_key: server.auth_key].to_json
        end

        it 'returns success status' do
          post :activate, params
          expect(response.status).to eq 200
        end

        it 'updates server pki fields' do
          expect { post :activate, params }
            .to change  { server.reload.server_crt }.to('server crt')
                                                    .and change { server.reload.client_crt }.to('client crt')
                                                                                            .and change { server.reload.client_key }.to('client key')
        end
      end

      context 'incorrect token' do
        let(:secret_token) { 'invalid_token' }

        it 'raises error' do
          expect do
            post :activate, params
          end.to raise_error ApiException, 'Server activation attempt with incorrect token'
        end
      end
    end
  end
end
