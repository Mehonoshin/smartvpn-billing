# frozen_string_literal: true

require 'spec_helper'

describe UserDecorator do
  let!(:user) { create(:user_with_balance) }
  let(:decorator) { user.decorate }

  describe '.connection_status' do
    subject { decorator.connection_status }

    context 'connected' do
      before { create(:connect, user: user) }

      it 'returns link to connection' do
        expect(subject).to include 'href='
      end
    end

    context 'disconnected' do
      it 'returns not connected text' do
        expect(subject).to eq I18n.t('admin.users.not_connected')
      end
    end
  end

  describe '.current_interval_payment_status' do
    subject { decorator.current_interval_payment_status }

    context 'paid' do
      let!(:withdrawal) { create(:withdrawal, user: user) }

      it 'returns last withdrawal date' do
        expect(subject).to eq described_class.h.human_date(withdrawal.created_at)
      end
    end

    context 'unpaid' do
      it 'returns unpaid text' do
        expect(subject).to eq I18n.t('admin.users.not_paid')
      end
    end
  end

  describe '.options' do
    subject { decorator.options }

    let(:option) { create(:active_option) }

    before { user.options << option }

    it 'includes option name' do
      expect(subject).to include option.name
    end
  end
end
