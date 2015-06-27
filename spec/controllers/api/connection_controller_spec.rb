require 'spec_helper'

describe Api::ConnectionController do
  let(:user) { create(:user) }
  let(:server) { create(:server) }
  let(:attrs) { Hash[login: user.vpn_login, hostname: server.hostname, traffic_in: 10, traffic_out: 15] }
  subject { response }

  it_behaves_like "validating signature", :connect
  it_behaves_like "validating signature", :disconnect

  describe "api calls" do
    before do
      Api::ConnectionController.any_instance.stubs(:valid_api_call?).returns(true)
    end

    describe "POST #connect" do
      it "calls connector" do
        Connector.any_instance.expects(:invoke).once
        post :connect, attrs
      end

      it "passed connect action to connector" do
        connector = Connector.new(attrs.merge!(action: "connect"))
        Connector.expects(:new).with() { |params| params.include?(:action) }.returns(connector)
        post :connect, attrs
      end

      context 'user has options' do
        let(:params) { attrs.merge!(action: 'connect') }

        before do
          option = create(:active_option)
          user.plan.options << option
          user.options << option
          post :connect, params
        end

        it { should be_json }

        it 'response includes options list' do
          expect(json).to have_key('options')
        end
      end
    end

    describe "POST #disconnect" do
      it "calls connector" do
        Connector.any_instance.expects(:invoke).once
        post :disconnect, attrs
      end

      it "passed disconnect action to connector" do
        connector = Connector.new(attrs.merge!(action: "connect"))
        Connector.expects(:new).with() { |params| params.include?(:action) }.returns(connector)
        post :disconnect, attrs
      end
    end
  end
end
