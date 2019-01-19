# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Connect do
  subject { build :proxy_connect }

  it { is_expected.to belong_to :proxy }
  it { is_expected.to belong_to :user }

  it 'has initial state' do
    expect(subject.state).to eq 'active'
  end
end
