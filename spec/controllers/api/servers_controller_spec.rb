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

    context "correct ip" do
      before do
        @request.env['REMOTE_ADDR'] = server.ip_address
      end

      it "renders json with auth key" do
        post :activate, hostname: server.hostname
        expect(response.body).to eq Hash[auth_key: server.auth_key].to_json
      end

      it "returns success status" do
        post :activate, hostname: server.hostname
        expect(response.status).to eq 200
      end
    end

    context "incorrect ip" do
      it "raises error" do
        expect{
          post :activate, hostname: server.hostname
        }.to raise_error ApiException
      end
    end

  end
end
