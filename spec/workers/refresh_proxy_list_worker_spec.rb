# frozen_string_literal: true

require 'rails_helper'

describe RefreshProxyListWorker do
  subject { described_class.new }

  context '#perform' do
    let(:adapter) { Proxy::Fetchers::FreeProxyListNet::WebParser }

    before { allow(Proxy::Updater).to receive(:update) }

    it 'executes Proxy::Updater.update once with correct params' do
      subject.perform
      expect(Proxy::Updater).to have_received(:update).once.with(adapter)
    end
  end
end
