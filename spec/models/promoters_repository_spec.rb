# frozen_string_literal: true

require 'spec_helper'

describe PromotersRepository do
  subject { described_class }

  let!(:custom_promoter) { OpenStruct.new(type: 'custom', attributes: []) }

  before { subject.persist(custom_promoter) }

  describe '.all' do
    it 'returns all promoters classes' do
      expect(subject.all).to eq [DiscountPromoter, custom_promoter]
    end
  end

  describe '.types' do
    it 'returns all types of promoters' do
      expect(subject.types).to eq %w[discount custom]
    end
  end

  describe '.clean' do
    it 'resets promoters list' do
      subject.persist(custom_promoter)
      subject.clean
      expect(subject.all).to eq [DiscountPromoter]
    end
  end

  describe '.persist' do
    before { subject.clean }

    it 'adds promoter to repo' do
      before_size = subject.all.size
      subject.persist(custom_promoter)
      expect(subject.all.size).to eq before_size + 1
    end
  end

  describe '.find_by_type' do
    it '.find_by_type' do
      expect(subject.find_by_type(:discount)).to eq DiscountPromoter
    end
  end
end
