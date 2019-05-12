# frozen_string_literal: true

require 'spec_helper'

describe TestPeriod do
  subject { described_class.new(user) }

  let(:user) { create(:user) }

  it 'test period is false by default' do
    expect(subject.enabled?).to be false
  end

  describe '#enable!' do
    it 'persists period start date' do
      expect do
        subject.enable!
      end.to change {
        user.test_period_started_at.try(:to_date)
      }.to Date.current
    end
  end

  describe '#disable!' do
    before { user.update(test_period_started_at: Date.current) }

    it 'removes period start date' do
      expect do
        subject.disable!
      end.to change {
        user.reload.test_period_started_at
      }.to nil
    end
  end

  context 'test period custom length' do
    before { user.update(test_period_started_at: Date.current, period_length: 5) }

    it 'returns custom value' do
      expect(subject.test_period_until.to_date).to eq (Date.current + 5.days)
    end
  end

  context 'default test period' do
    before { user.update(test_period_started_at: Date.current) }

    it 'returns custom value' do
      expect(subject.test_period_until.to_date).to eq (Date.current + User::DEFAULT_TEST_PERIOD)
    end
  end
end
