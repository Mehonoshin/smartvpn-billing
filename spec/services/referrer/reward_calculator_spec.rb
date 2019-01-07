# frozen_string_literal: true

require 'spec_helper'

describe Referrer::RewardCalculator do
  let(:payment) { create(:payment, amount: 100) }
  subject { described_class.new(payment) }

  describe '#amount' do
    before do
      described_class.any_instance.expects(:percent).returns(10)
    end

    it 'returns 10% of payment' do
      expect(subject.amount).to eq 10
    end
  end
end
