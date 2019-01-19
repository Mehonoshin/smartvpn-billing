# frozen_string_literal: true

require 'spec_helper'

describe WithdrawalProlongation do
  it { is_expected.to belong_to :withdrawal }

  it { is_expected.to validate_presence_of :withdrawal_id }
  it { is_expected.to validate_presence_of :days_number }
end
