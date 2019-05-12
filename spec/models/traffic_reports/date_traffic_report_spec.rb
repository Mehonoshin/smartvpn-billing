# frozen_string_literal: true

require 'spec_helper'

describe DateTrafficReport do
  subject { described_class.new(date_from: date_from, date_to: date_to) }

  let(:current_date) { DateTime.parse('13-06-2013') }
  let(:date_from) { current_date - 3.month }
  let(:date_to) { current_date.end_of_month }

  before do
    create(:disconnect, created_at: current_date)
    create(:disconnect, created_at: current_date)

    yesterday = create(:disconnect)
    yesterday.update(created_at: current_date - 1.day)

    month_ago = create(:disconnect)
    month_ago.update(created_at: current_date - 1.month + 3.days)
  end

  it 'returns report grouped by dates' do
    expect(subject.result.to_a.size).to eq 3
  end

  it 'sums traffic in' do
    todays_traffic_in = subject.result.to_a.first.traffic_in
    expect(todays_traffic_in).to eq attributes_for(:disconnect)[:traffic_in] * 2
  end

  it 'sums traffic out' do
    todays_traffic_out = subject.result.to_a.first.traffic_out
    expect(todays_traffic_out).to eq attributes_for(:disconnect)[:traffic_in] * 2
  end

  it 'casts created_at time to zero' do
    date_hour = subject.result.to_a.first.date.hour
    expect(date_hour).to be_zero
  end
end
