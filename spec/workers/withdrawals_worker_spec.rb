# frozen_string_literal: true

require 'rails_helper'

describe WithdrawalsWorker do
  subject { described_class.new }

  context '#perform' do
    let(:adapter) { Proxy::Fetchers::FreeProxyListNet::WebParser }

    before do
      allow(Withdrawer).to receive(:mass_withdrawal)
    end

    it 'executes correct methods with correct params' do
      expect_any_instance_of(UnpaidUsersNotificator).to receive(:notify_all).once
      subject.perform
      expect(Withdrawer).to have_received(:mass_withdrawal).once
    end
  end
end
