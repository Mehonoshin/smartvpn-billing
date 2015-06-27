require 'spec_helper'

describe Api::AuthenticationController do
  it_behaves_like "validating signature", :auth

  describe "POST #auth" do
    let(:user) { create(:user_with_balance) }
    let(:server) { create(:server) }

    before do
      user.plan.servers << server
      Api::AuthenticationController.any_instance.stubs(:valid_api_call?).returns(true)
    end

    context "valid credentials" do
      let(:params) { Hash[login: user.vpn_login, password: user.vpn_password, hostname: server.hostname] }
      before { create(:withdrawal, user: user) }

      it "returns 200 status" do
        post :auth, params
        expect(response.status).to eq 200
      end
    end

    context "invalid credentials" do
      let(:params) { Hash[login: user.vpn_login, password: "asd", hostname: server.hostname] }

      it "returns 404 status" do
        post :auth, params
        expect(response.status).to eq 404
      end
    end
  end

end

