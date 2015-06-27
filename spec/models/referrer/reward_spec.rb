require 'spec_helper'

describe Referrer::Reward do
  subject { build(:referrer_reward) }

  it { should validate_presence_of :referrer_id }
  it { should validate_presence_of :operation_id }
  it { should validate_presence_of :amount }
end
