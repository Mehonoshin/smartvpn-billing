# frozen_string_literal: true

require 'spec_helper'

describe TrafficReport do
  subject { described_class.new(params) }

  let(:params) { Hash[] }

  describe 'report building' do
    let(:report_ar_relation) { double('TrafficReport') }

    before do
      allow_any_instance_of(described_class).to receive(:build_report).and_return(report_ar_relation)
      allow(report_ar_relation).to receive(:where).and_return([])
    end

    it 'builds report on result call' do
      expect(subject.result).not_to be_nil
    end
  end

  context 'params on initialization passed' do
    let(:date_from) { '01-10-2013' }
    let(:date_to) { '31-10-2013' }
    let(:params) do
      {
        date_from: date_from,
        date_to: date_to
      }
    end

    it 'date_from returns date from params' do
      expect(subject.date_from).to eq date_from.to_time.beginning_of_month
    end

    it 'date_to returns date from params' do
      expect(subject.date_to).to eq date_to.to_time.end_of_month
    end
  end

  context 'no params passed' do
    it 'date from equals beginning of month' do
      expect(subject.date_from).to eq Time.current.beginning_of_month
    end

    it 'date to equals end of month' do
      expect(subject.date_to).to eq Time.current.end_of_month
    end
  end
end
