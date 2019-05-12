# frozen_string_literal: true

require 'spec_helper'

describe Api::ConnectionSerializer do
  subject { described_class.new(object) }

  let(:option) { create(:option) }
  let(:option_attributes) do
    {
      option.code => { 'attr1' => 'attr1_value' }
    }
  end
  let(:object) { create(:connect, option_attributes: option_attributes) }
  let(:user) { object.user }

  it 'includes option code' do
    expect(subject.to_json).to include option.code
  end

  it 'includes options block' do
    expect(subject.to_json).to include 'options'
  end

  it 'includes options attributes block' do
    expect(subject.to_json).to include 'option_attributes'
  end

  it 'includes common_name key' do
    expect(subject.to_json).to include 'common_name'
  end

  it 'includes user vpn_login' do
    expect(subject.to_json).to include user.vpn_login
  end

  describe 'option_attributes block' do
    let(:json) { subject.to_json }

    it 'includes option code' do
      expect(json).to include option.code
    end

    it 'includes option attr name' do
      expect(json).to include option_attributes[option.code].keys.first
    end

    it 'includes option attr value' do
      expect(json).to include option_attributes[option.code].values.first
    end
  end
end
