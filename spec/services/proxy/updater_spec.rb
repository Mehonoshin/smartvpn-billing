# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Updater do
  describe '.update' do
    let(:fetcher_class) { double('fetcher_class') }
    let(:proxies) { [] }
    subject { described_class }

    before do
      expect(fetcher_class).to receive(:fetch).and_return(proxies)
    end

    it 'gets proxies from fetcher' do
      subject.update(fetcher_class)
    end

    it 'persists proxies collection' do
      expect(Proxy::Repository).to receive(:persist).with(proxies)
      subject.update(fetcher_class)
    end
  end
end
