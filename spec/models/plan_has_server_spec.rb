# frozen_string_literal: true

require 'spec_helper'

describe PlanHasServer do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:plan) }
end

# == Schema Information
#
# Table name: plan_has_servers
#
#  id         :integer          not null, primary key
#  server_id  :integer
#  plan_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
