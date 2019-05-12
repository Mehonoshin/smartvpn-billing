# frozen_string_literal: true

require 'spec_helper'

describe PaySystemDecorator do
  subject { described_class.new(pay_system) }

  let(:pay_system) { create(:pay_system) }

  describe '.title' do
    it 'creates link' do
      expect(subject.title).to include 'href'
    end

    it 'uses pay system name as link anchor' do
      expect(subject.title).to include pay_system.name
    end
  end

  describe '.human_state' do
    it 'localizes state' do
      expect(subject.human_state).to eq I18n.t("admin.pay_systems.states.#{pay_system.state}")
    end
  end
end
