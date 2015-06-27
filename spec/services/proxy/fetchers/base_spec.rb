require 'spec_helper'

describe Proxy::Fetchers::Base do
  subject { described_class }

  describe '.fetch' do
    context 'child class' do
      it 'calls #fetch_proxy_list' do
        subject.any_instance.expects(:fetch_proxy_list)
        subject.fetch
      end
    end

    context 'parent class' do
      it 'raises error' do
        expect {
          subject.fetch
        }.to raise_error NotImplementedException
      end
    end
  end
end
