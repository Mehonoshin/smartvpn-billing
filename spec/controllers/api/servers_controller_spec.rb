# frozen_string_literal: true

require 'spec_helper'

describe Api::ServersController do
  let(:hostname) { 'valid_hostname' }
  let(:signature) { ENV['SECRET_TOKEN'] }

  describe 'POST #activate' do
    let(:params) do
      attributes_for(:server).merge(
        signature: signature,
        hostname: hostname,
        server_crt: 'server crt',
        client_crt: 'client crt',
        client_key: 'client key'
      )
    end

    context 'when server exists' do
      let!(:server) { create(:server) }
      let(:hostname) { server.hostname }

      it 'raises error' do
        expect do
          post :activate, params: params
        end.to raise_error ApiException, "Server already exists: #{server}"
      end
    end

    context 'server does not exist' do
      context 'correct token' do
        let(:server) { Server.last }

        it 'renders json with auth key' do
          post :activate, params: params
          expect(response.body).to eq Hash[auth_key: server.auth_key].to_json
        end

        it 'returns success status' do
          post :activate, params: params
          expect(response.status).to eq 200
        end

        it 'updates server pki fields' do
          expect { post :activate, params: params }
            .to change(Server, :count).by(1)
        end

        it 'assigns certificate data to server' do
          post :activate, params: params
          expect(server.server_crt).to eq('server crt')
          expect(server.client_crt).to eq('client crt')
          expect(server.client_key).to eq('client key')
        end
      end

      context 'incorrect token' do
        let(:hostname) { 'some_hostname' }
        let(:signature) { 'invalid_token' }

        it 'raises error' do
          expect do
            post :activate, params: params
          end.to raise_error ApiException, "Server activation attempt with incorrect token: #{signature}"
        end
      end
    end
  end
end
