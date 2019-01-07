# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Rater do
  subject { described_class }

  describe '.find_best' do
    let(:country) { 'China' }
    let(:user) { create(:user) }
    let(:option) { create(:proxy_option) }
    let!(:activated_option) { create(:user_option, user: user, option: option, attrs: { country: country }) }
    let(:result) { subject.new(user, option).find_best }

    before do
      create(:proxy_node, country: 'Russia', ping: 20)
      create(:proxy_node, country: 'China', ping: 100)
      create(:proxy_node, country: 'China', ping: 125)
      create(:proxy_node, country: 'Usa', ping: 150)
    end

    it 'returns proxy object' do
      expect(result.class).to eq Proxy::Node
    end

    it 'returns proxy with smallest ping' do
      expect(result.ping).to eq 100
    end

    it 'returns proxy for requested country' do
      expect(result.country).to eq country
    end

    context 'no proxy for selected country' do
      let(:country) { 'Uk' }

      it 'returns proxy for other country' do
        expect(result.country).not_to be_nil
      end
    end
  end
end
