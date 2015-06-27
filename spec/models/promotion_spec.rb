require 'spec_helper'

describe Promotion do
  it { should belong_to :user }
  it { should belong_to :promo }

  describe "uniqueness validation" do
    let(:promo1) { create(:promo) }
    let(:promo2) { create(:promo) }
    let(:user) { create(:user) }

    before do
      create(:promotion, user: user, promo: promo1)
    end

    it "does not allow to create second promotion with same promo for user" do
      second_promotion = build(:promotion, user: user, promo: promo1)
      expect(second_promotion).not_to be_valid
    end

    it "allows user to have multiple promotions with different promos" do
      second_promotion = build(:promotion, user: user, promo: promo2)
      expect(second_promotion).to be_valid
    end
  end

  describe "with_active_promos scope" do
    subject { described_class }

    before do
      create(:promotion, promo: create(:promo))
      create(:promotion, promo: create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now))
      create(:promotion, promo: create(:promo))
      create(:promotion, promo: create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now))
    end

    it 'returns promotions with active promos' do
      expect(subject.with_active_promos.size).to eq 2
    end

    it 'promo are active' do
      expect(subject.with_active_promos.last.promo.active?).to be true
    end
  end

  describe "#apply method" do
    let(:promo) { create(:promo) }
    let(:promotion) { create(:promotion, promo: promo) }
    let(:amount) { 100 }

    it 'calls apply method on promo promoter' do
      promo.promoter.expects(:apply).with(promo, amount)
      promotion.apply(amount)
    end
  end
end

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  promo_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

