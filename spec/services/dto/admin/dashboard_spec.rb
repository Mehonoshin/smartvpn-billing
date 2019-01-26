# frozen_string_literal: true

require 'rails_helper'

describe Dto::Admin::Dashboard do
  let(:dashboard) { described_class.new }
  subject { dashboard }

  before do
    redis = Redis.new
    redis.set('smartvpn:eur_usd', 10)
    redis.set('smartvpn:rub_usd', 10)
    redis.set('smartvpn:courses:updated_at', Time.current)
  end

  describe 'courses' do
    subject { dashboard.courses }

    it 'returns date of last course update' do
      expect(subject[:updated_at]).not_to be_nil
    end

    context 'courses exist' do
      it 'loads rub course' do
        expect(subject[:rub_usd]).not_to be_nil
      end

      it 'loads eur course' do
        expect(subject[:eur_usd]).not_to be_nil
      end
    end
  end

  describe 'incomes' do
    subject { dashboard.income }
    before do
      2.times { create(:payment, amount: 100) }
    end

    it_behaves_like 'total statistics result', 200
    it_behaves_like 'total statistics discrete result', Dto::Admin::Dashboard
  end

  describe 'traffic' do
    subject { dashboard.traffic }
    before do
      2.times { create(:disconnect, traffic_in: 100, traffic_out: 100) }
    end

    it_behaves_like 'total statistics result', 200
    it_behaves_like 'total statistics discrete result', Dto::Admin::Dashboard
  end
end
