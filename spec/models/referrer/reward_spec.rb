# frozen_string_literal: true

require 'spec_helper'

describe Referrer::Reward do
  subject { build(:referrer_reward) }

  it { is_expected.to validate_presence_of :referrer_id }
  it { is_expected.to validate_presence_of :operation_id }
  it { is_expected.to validate_presence_of :amount }
end
