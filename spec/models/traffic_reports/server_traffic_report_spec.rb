# frozen_string_literal: true

require 'spec_helper'

describe ServerTrafficReport do
  subject { described_class.new(date_from: date_from, date_to: date_to) }

  let(:current_date) { DateTime.parse('13-06-2013') }
  let(:date_from) { current_date - 3.month }
  let(:date_to) { current_date.end_of_month }

  let(:first_server) { create(:server) }
  let(:second_server) { create(:server) }
  let(:third_server) { create(:server) }

  before do
    create(:disconnect, server: first_server, created_at: current_date)
    create(:disconnect, server: first_server, created_at: current_date)

    create(:disconnect, server: second_server, created_at: current_date)
    create(:disconnect, server: third_server, created_at: current_date)
  end

  it 'returns report grouped by servers' do
    expect(subject.result.to_a.size).to eq 3
  end

  it 'sums traffic in' do
    first_server_traffic_in = subject.result.to_a.first.traffic_in
    expect(first_server_traffic_in).to eq attributes_for(:disconnect)[:traffic_in] * 2
  end

  it 'sums traffic out' do
    first_server_traffic_out = subject.result.to_a.first.traffic_out
    expect(first_server_traffic_out).to eq attributes_for(:disconnect)[:traffic_out] * 2
  end

  it 'second server has only its own traffic' do
    expect(subject.result.to_a[1].traffic_in).to eq attributes_for(:disconnect)[:traffic_in]
    expect(subject.result.to_a[1].traffic_out).to eq attributes_for(:disconnect)[:traffic_out]
  end

  it 'third server has only its own traffic' do
    expect(subject.result.to_a[2].traffic_in).to eq attributes_for(:disconnect)[:traffic_in]
    expect(subject.result.to_a[2].traffic_out).to eq attributes_for(:disconnect)[:traffic_out]
  end
end
