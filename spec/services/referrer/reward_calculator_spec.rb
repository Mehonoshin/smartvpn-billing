# frozen_string_literal: true

require 'spec_helper'

describe Referrer::RewardCalculator do
  subject { described_class.new(payment) }

  let(:payment) { create(:payment, amount: 100) }

  describe '#amount' do
    before do
      allow_any_instance_of(described_class).to receive(:percent).and_return(10)
    end

    it 'returns 10% of payment' do
      expect(subject.amount).to eq 10
    end
  end
end
