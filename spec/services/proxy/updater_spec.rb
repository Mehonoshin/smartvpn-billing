# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Updater do
  describe '.update' do
    let(:fetcher_class) { mock }
    let(:proxies) { [] }
    subject { described_class }

    before do
      fetcher_class.expects(:fetch).returns(proxies)
    end

    it 'gets proxies from fetcher' do
      subject.update(fetcher_class)
    end

    it 'persists proxies collection' do
      Proxy::Repository.expects(:persist).with(proxies)
      subject.update(fetcher_class)
    end
  end
end
