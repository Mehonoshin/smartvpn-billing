# frozen_string_literal: true

require 'spec_helper'

describe PromoDecorator do
  subject { described_class.new(promo) }

  let(:promo) { create(:promo) }

  describe 'period' do
    it 'returns string with start date' do
      expect(subject.period).to include described_class.h.human_date(promo.date_from, time: false)
    end

    it 'returns string with end date' do
      expect(subject.period).to include described_class.h.human_date(promo.date_to, time: false)
    end
  end

  describe 'type' do
    it 'returns translation of field' do
      expect(subject.type).to eq I18n.t("activerecord.attributes.promo.types.#{promo.type}")
    end
  end

  describe 'promoter type' do
    it 'returns translation of field' do
      expect(subject.promoter_type).to eq I18n.t("activerecord.attributes.promoter.types.#{promo.promoter_type}")
    end
  end

  describe 'state' do
    it 'translates state name' do
      expect(subject.state).to include I18n.t("activerecord.attributes.promo.states.#{promo.state}")
    end

    it 'wraps in span' do
      expect(subject.state).to include '<span'
    end

    context 'active' do
      before { promo.start! }

      it 'adds green color to span' do
        expect(subject.state).to include 'green'
      end
    end

    context 'pending' do
      it 'adds red color to span' do
        expect(subject.state).to include 'red'
      end
    end
  end
end
