require 'spec_helper'

describe Api::ServersController do
  let!(:server) { create(:server) }

  describe "POST #activate" do
    context "hostname not present in DB" do
      it "raises error" do
        expect {
          post :activate, hostname: "incorrect.domain"
        }.to raise_error ApiException, "Server for activation not found"
      end
    end

    describe 'server ip validation' do
      let(:params) do
        {
          hostname: server.hostname,
          server_crt: 'server crt',
          client_crt: 'client crt',
          client_key: 'client key'
        }
      end

      context "correct ip" do
        before do
          @request.env['REMOTE_ADDR'] = server.ip_address
        end

        it "renders json with auth key" do
          post :activate, params
          expect(response.body).to eq Hash[auth_key: server.auth_key].to_json
        end

        it "returns success status" do
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

      context 'incorrect ip' do
        it 'raises error' do
          expect {
            post :activate, params
          }.to raise_error ApiException
        end
      end
    end
  end
end
