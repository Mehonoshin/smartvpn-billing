# frozen_string_literal: true

require 'spec_helper'

describe Authenticator do
  subject { described_class.new(login, password, hostname) }

  let(:user) { create(:user_with_balance) }
  let(:server) { create(:server) }
  let(:login) { user.vpn_login }
  let(:password) { user.vpn_password }
  let(:hostname) { server.hostname }

  before do
    user.plan.servers << server
  end

  describe '#valid_password?' do
    context 'vpn credentials' do
      context 'with valid credentials' do
        before { create(:withdrawal, user: user) }

        it 'returns true' do
          expect(subject.valid_credentials?).to be true
        end
      end

      context 'with invalid credentials' do
        let(:password) { "#{user.vpn_password}RandomString" }

        it 'returns false' do
          expect(subject.valid_credentials?).to be false
        end
      end
    end

    context 'billing credentials' do
      let(:login) { user.email }

      before { create(:withdrawal, user: user) }

      context 'valid' do
        let(:password) { 'password' }

        it 'returns true' do
          expect(subject.valid_credentials?).to be true
        end
      end

      context 'invalid' do
        let(:password) { 'invalid-password' }

        it 'returns true' do
          expect(subject.valid_credentials?).to be false
        end
      end
    end

    context 'when already connected' do
      before do
        user.connects.create!(server_id: server.id)
      end

      it 'returns false' do
        expect(subject.valid_credentials?).to be false
      end
    end

    context 'user is disabled' do
      before do
        user.disable!
      end

      it 'returns false' do
        expect(subject.valid_credentials?).to be false
      end
    end

    context 'didnt pay anything' do
      it 'returns false' do
        expect(subject.valid_credentials?).to be false
      end
    end

    context 'server does not belong to plan' do
      let!(:server) { create(:server) }

      it 'returns false' do
        expect(subject.valid_credentials?).to be false
      end
    end

    describe 'test period' do
      context 'not enabled' do
        it 'returns false' do
          expect(subject.valid_credentials?).to be false
        end
      end

      context 'enabled and active' do
        before { user.test_period.enable! }

        it 'returns true' do
          expect(subject.valid_credentials?).to be true
        end
      end

      context 'enabled and expired' do
        before do
          user.update(test_period_started_at: 1.month.ago)
        end

        it 'returns false' do
          expect(subject.valid_credentials?).to be false
        end
      end
    end
  end
end
