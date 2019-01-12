# frozen_string_literal: true

require 'spec_helper'

describe Disconnect do
  subject { build(:disconnect) }

  it { should be_valid }
  it { should belong_to(:user) }
  it { should belong_to(:server) }

  it { should validate_presence_of(:traffic_in) }
  it { should validate_presence_of(:traffic_out) }

  it_behaves_like 'loads created by last days', :disconnect

  describe 'instance' do
    subject { create(:disconnect) }

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
