require 'spec_helper'

describe Options::Hooks::Proxy do
  let(:user) { create(:user) }
  let(:option) { create(:option, code: 'proxy') }
  let(:proxy) { create(:proxy_node) }
  subject { described_class.new(user, option) }

  describe '.connect' do
    before do
      ::Proxy::Rater.any_instance.expects(:find_best).returns(proxy)
    end

    it 'calls proxy rater' do
      subject.connect
    end

    it 'creates proxy connect record' do
      expect {
        subject.connect
      }.to change(proxy.connects, :count).by(1)
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
