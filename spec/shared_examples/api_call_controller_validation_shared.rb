# frozen_string_literal: true

shared_examples 'validating signature' do |action| # rubocop:disable Metrics/BlockLength
  describe 'request validation' do # rubocop:disable Metrics/BlockLength
    let(:server) { create(:server) }
    let(:hostname) { server.hostname }
    let(:attrs) { Hash[hostname: hostname] }

    describe 'server hostname' do
      context 'when does not exist' do
        let(:hostname) { 'non_existing_hostname' }

        it 'raises error' do
          expect do
            post action, params: attrs
          end.to raise_error ApiException, 'Server not found'
        end
      end
    end

    describe 'server status' do
      context 'when pending' do
        it 'raises error' do
          expect do
            post action, params: attrs
          end.to raise_error ApiException, 'Server not active'
        end
      end

      context 'when disabled' do
        let(:server) { create(:disabled_server) }

        it 'raises error' do
          expect do
            post action, params: attrs
          end.to raise_error ApiException, 'Server not active'
        end
      end
    end

    describe 'signature' do
      let(:server) { create(:active_server) }

      context 'when incorrect' do
        let(:attrs) do
          {
            hostname: server.hostname,
            signature: 'incorrect_auth_key'
          }
        end

        it 'raises error' do
          expect do
            post action, params: attrs
          end.to raise_error ApiException, 'Invalid api call'
        end
      end
    end
  end
end
