# frozen_string_literal: true

require 'spec_helper'

describe Connect do
  subject { build(:connect) }

  it { should be_valid }
  it { should belong_to(:user) }
  it { should belong_to(:server) }

  describe 'instance' do
    subject { create(:connect) }

    it 'returns server hostname' do
      expect(subject.hostname).to eq subject.server.hostname
    end
  end
end

# == Schema Information
#
# Table name: connections
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  server_id   :integer
#  traffic_in  :float
#  traffic_out :float
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
