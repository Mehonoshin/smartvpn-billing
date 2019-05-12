# frozen_string_literal: true

require 'rails_helper'

describe Dto::Admin::DiscreteBase do
  subject { described_class.new(number_of_days: days_number) }

  let(:days_number) { 3 }

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
