# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Node do
  subject { build(:proxy_node) }

  it { is_expected.to validate_presence_of :host }
  it { is_expected.to validate_presence_of :port }
  it { is_expected.to validate_presence_of :country }
  it { is_expected.to have_many :connects }
end
