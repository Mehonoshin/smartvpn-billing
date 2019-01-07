# frozen_string_literal: true

require 'spec_helper'

describe WithdrawalProlongation do
  it { should belong_to :withdrawal }

  it { should validate_presence_of :withdrawal_id }
  it { should validate_presence_of :days_number }
end
