# frozen_string_literal: true

require 'rails_helper'

describe Server::Signature do
  subject { described_class.new(server, request_params) }

  describe '#valid?' do
    let(:request_params) do
      {
        hostname: 'some_host_name',
        ip_address: 'ip_address',
        some_key: 'some_key',
        signature: signature
      }
    end

    context 'when server does not exist' do
      let(:server) { nil }

      context 'with valid signature' do
        let(:signature) { ENV['SECRET_TOKEN'].to_s }

        its(:valid?) { is_expected.to be true }
      end

      context 'with invalid signature' do
        let(:signature) { 'invalid_signature' }

        its(:valid?) { is_expected.to be false }
      end
    end

    context 'when server exists' do
      let!(:server) { create(:server) }

      before { server.update!(auth_key: 'QFEJYWWU') }

      context 'with valid signature' do
        let(:signature) { '4db645f94cd9af74ba4d8fb21b952f20' }

        its(:valid?) { is_expected.to be true }

        it 'calls Signer with cleaned params' do
          clean_params = request_params.reject { |(k, _v)| k == :signature }
          expect(Signer).to receive(:sign_hash).with(clean_params, server.auth_key)
          subject.valid?
        end
      end

      context 'with invalid signature' do
        let(:signature) { '123' }

        its(:valid?) { is_expected.to be false }
      end
    end
  end
end
