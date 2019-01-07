# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Node do
  subject { build(:proxy_node) }

  it { should validate_presence_of :host }
  it { should validate_presence_of :port }
  it { should validate_presence_of :country }
  it { should have_many :connects }
end
