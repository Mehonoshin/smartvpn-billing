# frozen_string_literal: true

shared_examples 'validating signature' do |action|
  describe 'request validation' do
    let(:server) { create(:server) }
    let(:attrs) { Hash[hostname: server.hostname] }

    describe 'server hostname and ip' do
      context 'not match' do
        before do
          @request.env['REMOTE_ADDR'] = '10.2.4.5'
        end

        it 'raises error' do
          expect do
            post action, attrs
          end.to raise_error ApiException, 'Server not found'
        end
      end
    end

    describe 'server status' do
      before do
        @request.env['REMOTE_ADDR'] = server.ip_address
      end

      context 'pending' do
        it 'raises error' do
          expect do
            post action, attrs
          end.to raise_error ApiException, 'Server not active'
        end
      end

      context 'disabled' do
        let(:server) { create(:disabled_server) }

        it 'raises error' do
          expect do
            post action, attrs
          end.to raise_error ApiException, 'Server not active'
        end
      end
    end

    describe 'signature' do
      let(:server) { create(:active_server) }

      before do
        @request.env['REMOTE_ADDR'] = server.ip_address
      end

      context 'incorrect' do
        let(:attrs) { Hash[hostname: server.hostname, signature: Signer.sign_hash({ hostname: server.hostname }, 'incorrect_auth_key')] }

        it 'raises error' do
          expect do
            post action, attrs
          end.to raise_error ApiException, 'Invalid api call'
        end
      end
    end
  end
end
