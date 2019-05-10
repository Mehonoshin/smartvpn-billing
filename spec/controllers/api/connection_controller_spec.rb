# frozen_string_literal: true

require 'spec_helper'

describe Api::ConnectionController do
  let(:user) { create(:user) }
  let(:server) { create(:server) }
  let(:attrs) { { login: user.vpn_login,
                  hostname: server.hostname,
                  traffic_in: '10',
                  traffic_out: '15' } }
  subject { response }

  it_behaves_like 'validating signature', :connect
  it_behaves_like 'validating signature', :disconnect

  describe 'api calls' do
    before do
      allow_any_instance_of(Api::ConnectionController).to receive(:valid_api_call?).and_return(true)
    end

    describe 'POST #connect' do
      it 'calls connector' do
        allow_any_instance_of(Connector).to receive(:invoke).once
        post :connect, attrs
      end

      it 'passed connect action to connector' do
        connector = Connector.new(attrs.merge!(action: 'connect'))
        expect(Connector).to receive(:new).with(attrs).and_return(connector)
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

        it { is_expected.to be_json }

        it 'response includes options list' do
          expect(json).to have_key('options')
        end
      end
    end

    describe 'POST #disconnect' do
      it 'calls connector' do
        allow_any_instance_of(Connector).to receive(:invoke).once
        post :disconnect, attrs
      end

      it 'passed disconnect action to connector' do
        connector = Connector.new(attrs.merge!(action: 'disconnect'))
        expect(Connector).to receive(:new).with(attrs).and_return(connector)
        post :disconnect, attrs
      end
    end
  end
end
