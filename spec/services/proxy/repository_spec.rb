# frozen_string_literal: true

require 'spec_helper'

describe Proxy::Repository do
  subject { described_class }

  describe '.persist' do
    let!(:persisted_proxy) { create(:proxy_node) }

    context 'valid collection' do
      let(:proxies) do
        [
          { host: '127.0.0.1', port: 3000, country: 'Russia' },
          { host: '127.0.0.2', port: 3000, country: 'Russia' }
        ]
      end

      it 'persists collection' do
        expect do
          subject.persist(proxies)
        end.to change(Proxy::Node, :count).by(1)
      end

      it 'contains only new proxies' do
        subject.persist(proxies)
        expect(Proxy::Node.count).to eq 2
      end

      it 'does not contain old proxy' do
        subject.persist(proxies)
        expect(Proxy::Node.first.id).not_to eq persisted_proxy.id
      end
    end

    context 'invalid collection' do
      let(:proxies) do
        [
          { host: '127.0.0.1', port: 3000, country: 'Russia' },
          { host: nil, port: 3000, country: 'Russia' }
        ]
      end

      it 'does not persist collection' do
        expect do
          subject.persist(proxies)
        end.not_to change(Proxy::Node, :count)
      end

      it 'contains old proxy', disable_transaction: true, pending: 'Find out why transaction does not work' do
        subject.persist(proxies)
        expect(Proxy::Node.first.host).to eq persisted_proxy.host
      end

      it 'contains only old proxy' do
        subject.persist(proxies)
        expect(Proxy::Node.count).to eq 1
      end
    end
  end
end
