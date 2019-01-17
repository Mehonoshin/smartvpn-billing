# frozen_string_literal: true

require 'spec_helper'

describe Dto::Admin::DescreteBase do
  let(:days_number) { 3 }
  subject { described_class.new(days_number) }

  describe '#amounts' do
    before do
      allow_any_instance_of(described_class).to receive(:values_by_days).and_return({})
    end

    it 'calls values_by_days method' do
      subject.amounts
    end

    it 'adds records for all absent days in result' do
      expect(subject.amounts.size).to eq days_number
    end
  end
end
