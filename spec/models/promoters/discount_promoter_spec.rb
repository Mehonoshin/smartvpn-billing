# frozen_string_literal: true

require 'spec_helper'

describe DiscountPromoter do
  subject { described_class }

  describe '.apply' do
    let!(:promo) { create(:promo, attrs: { 'discount_percent' => 30 }) }

    it 'makes discount from base amount' do
      expect(subject.apply(promo, 100)).to eq 70
    end
  end

  describe '.type' do
    it 'returns type' do
      expect(subject.type).to eq 'discount'
    end
  end

  describe 'attributes' do
    it 'returns array of attributes' do
      expect(subject.attributes).to eq [:discount_percent]
    end
  end
end
