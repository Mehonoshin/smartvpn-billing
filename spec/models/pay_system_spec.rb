# frozen_string_literal: true

require 'spec_helper'

describe PaySystem do
  subject { build(:pay_system) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to have_many(:payments) }

  describe '.enabled scope' do
    subject { described_class }

    before do
      create_list(:enabled_pay_system, 2)
      create_list(:pay_system, 3)
    end

    it 'returns only enabled pay systems' do
      expect(subject.enabled.size).to eq 2
    end
  end

  describe 'states' do
    subject { build(:pay_system) }

    it 'initially in disabled state' do
      expect(subject.disabled?).to be true
    end

    context 'enable! action' do
      it 'changes state to enabled' do
        expect do
          subject.enable!
        end.to change(subject, :state).to('enabled')
      end
    end

    context 'disable! action' do
      before { subject.enable! }

      it 'changes state to disabled' do
        expect do
          subject.disable!
        end.to change(subject, :state).to('disabled')
      end
    end
  end
end

# == Schema Information
#
# Table name: pay_systems
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#
