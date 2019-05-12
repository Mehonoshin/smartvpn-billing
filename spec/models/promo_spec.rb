# frozen_string_literal: true

require 'spec_helper'

describe Promo do
  subject { promo }

  let(:promo) { build(:promo, promoter_type: 'discount') }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :promoter_type }
  end

  describe '.withdrawal scope' do
    subject { described_class.withdrawal }

    let!(:withdrawal1) { create(:promo) }
    let!(:withdrawal2) { create(:promo) }
    let!(:withdrawal3) { create(:option_promo) }

    it 'returns only withdrawal promos' do
      expect(subject).to eq [withdrawal1, withdrawal2]
    end
  end

  describe '.active scope' do
    let!(:active) { create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now) }
    let!(:inactive) { create(:promo) }
    let!(:active_but_expired) { create(:promo, date_from: 1.month.ago, date_to: 1.week.ago) }

    it 'returns promos with active state and that runs today' do
      expect(described_class.active).to include active
    end

    it 'does not return promo with expired date' do
      expect(described_class.active).not_to include active_but_expired
    end

    it 'does not returns promo with inactive state' do
      expect(described_class.active).not_to include inactive
    end
  end

  describe 'states' do
    it 'initial state' do
      expect(promo.state).to eq 'pending'
    end

    context 'start! event' do
      before { subject.start! }

      it 'turns to active' do
        expect(subject.state).to eq 'active'
      end
    end

    context 'stop!' do
      before do
        subject.start!
        subject.stop!
      end

      it 'turns to pending' do
        expect(subject.state).to eq 'pending'
      end
    end
  end

  describe '#promoter' do
    it 'calls promoters repository' do
      expect(PromotersRepository).to receive(:find_by_type).with(promo.promoter_type)
      subject.promoter
    end

    it 'returns according promoter' do
      expect(subject.promoter).to eq DiscountPromoter
    end
  end
end

# == Schema Information
#
# Table name: promos
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  type          :string(255)
#  date_from     :date
#  date_to       :date
#  promoter_type :string(255)
#  promo_code    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  attrs         :hstore           default({})
#
