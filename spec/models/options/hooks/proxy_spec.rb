# frozen_string_literal: true

require 'spec_helper'

describe Options::Hooks::Proxy do
  subject { described_class.new(user, option) }

  let(:user) { create(:user) }
  let(:option) { create(:option, code: 'proxy') }
  let(:proxy) { create(:proxy_node) }

  describe '.connect' do
    before do
      allow_any_instance_of(::Proxy::Rater).to receive(:find_best).and_return(proxy)
    end

    it 'calls proxy rater' do
      subject.connect
    end

    it 'creates proxy connect record' do
      expect do
        subject.connect
      end.to change(proxy.connects, :count).by(1)
    end

    it 'returns hash' do
      expect(subject.connect.class).to eq Hash
    end

    it 'result contains proxy host' do
      expect(subject.connect[:host]).to eq proxy.host
    end

    it 'result contains proxy host' do
      expect(subject.connect[:port]).to eq proxy.port
    end
  end
end
