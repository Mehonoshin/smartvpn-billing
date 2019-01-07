# frozen_string_literal: true

require 'spec_helper'

describe Server do
  subject { build(:server) }

  it { should be_valid }
  it { should have_many(:connects) }
  it { should have_many(:disconnects) }
  it { should have_many(:included_plans) }
  it { should have_many(:plans) }

  it { validate_presence_of(:hostname) }
  it { validate_presence_of(:ip_address) }
  it { validate_presence_of(:protocol) }
  it { validate_presence_of(:port) }
  it { validate_presence_of(:country_code) }

  it 'does not allow unknown protocol' do
    subject.protocol = 'unknown'
    expect(subject).not_to be_valid
  end

  context 'after creation' do
    it 'generates auth key' do
      expect(subject.save).not_to be_nil
    end

    it 'auth key is random' do
      expect(subject.save).not_to eq create(:server).auth_key
    end

    it 'is in pending state' do
      expect(subject.pending?).to be true
    end
  end

  describe '.to_s' do
    it 'returns hostname' do
      expect(subject.to_s).to eq subject.hostname
    end
  end
end

# == Schema Information
#
# Table name: servers
#
#  id         :integer          not null, primary key
#  hostname   :string(255)
#  ip_address :string(255)
#  auth_key   :string(255)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :string(255)
#
