# frozen_string_literal: true

require 'spec_helper'

describe Dto::Admin::DescreteBase do
  let(:days_number) { 3 }
  subject { described_class.new(days_number) }

  describe '#amounts' do
    before do
      described_class.any_instance.expects(:values_by_days).at_least_once.returns({})
    end

    it 'calls values_by_days method' do
      subject.amounts
    end

    it 'adds records for all absent days in result' do
      expect(subject.amounts.size).to eq days_number
    end
  end
end
