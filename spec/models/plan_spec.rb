# frozen_string_literal: true

require 'spec_helper'

describe Plan do
  subject(:plan) { build(:plan) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:included_servers) }
  it { is_expected.to have_many(:servers) }

  it { is_expected.to have_and_belong_to_many(:options) }

  describe 'regular plans scope' do
    subject { described_class.regular }

    let!(:special_plan) { create(:plan, special: true) }
    let!(:regular_plan1) { create(:plan) }
    let!(:regular_plan2) { create(:plan) }

    it 'returns non-special plans' do
      expect(subject).to eq [regular_plan1, regular_plan2]
    end

    it 'does not return special plans' do
      expect(subject).not_to include special_plan
    end
  end

  describe 'enabled' do
    subject { described_class.enabled }

    let(:enabled_plan1) { create(:plan) }
    let(:enabled_plan2) { create(:plan) }
    let(:disabled_plan) { create(:plan, enabled: false) }

    it 'returns only enabled plans' do
      expect(subject).to eq [enabled_plan1, enabled_plan2]
    end

    it 'does not return disabled plan' do
      expect(subject).not_to include disabled_plan
    end
  end

  describe '.to_s' do
    it 'returns its name' do
      expect(subject.to_s).to eq subject.name
    end
  end

  describe '.option_price' do
    let(:option) { create(:option) }
    let(:option_price) { 100 }

    before { plan.update(option_prices: { option.code => option_price }) }

    it 'returns option price by its code' do
      expect(plan.option_price(option.code)).to eq option_price
    end
  end
end

# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  price       :decimal(, )
#  description :text
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  special     :boolean          default(FALSE)
#  enabled     :boolean          default(FALSE)
#
