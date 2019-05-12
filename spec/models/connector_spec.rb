# frozen_string_literal: true

require 'spec_helper'

describe Connector do
  subject { described_class.new(params) }

  let(:user) { create(:user) }
  let(:server) { create(:server) }

  describe 'connection test methods' do
    subject { described_class }

    let(:user) { create(:user) }

    describe '#first_time_connected?' do
      context 'only one connect exists' do
        before { create(:connect, user: user) }

        it 'returns true' do
          expect(subject).to be_first_time_connected(user)
        end
      end

      context 'disconnects exist too' do
        before do
          create(:connect, user: user)
          create(:disconnect, user: user)
        end

        it 'returns false' do
          expect(subject).not_to be_first_time_connected(user)
        end
      end
    end

    describe '#connected?' do
      context 'only one connect exists' do
        before { create(:connect, user: user) }

        it 'returns true' do
          expect(subject).to be_connected(user)
        end
      end

      context 'disconnects exist too' do
        before do
          create(:disconnect, user: user)
          create(:disconnect, user: user)
          create(:connect, user: user, server: server)
        end

        it 'returns true' do
          expect(subject.connected?(user)).to be true
        end
      end

      context 'disconnect exists after connect' do
        before do
          create(:disconnect, user: user)
          create(:connect, user: user, server: server)
          create(:disconnect, user: user)
        end

        it 'returns false' do
          expect(subject.connected?(user)).to be false
        end
      end
    end
  end

  context 'login is email' do
    let(:params) { Hash[login: user.email, hostname: server.hostname, action: 'connect'] }

    it 'creates connect record for user' do
      expect do
        subject.invoke
      end.to change(user.connects, :count).by(1)
    end
  end

  context 'action is connect' do
    let(:params) { Hash[login: user.vpn_login, hostname: server.hostname, action: 'connect'] }

    it 'creates connect record for user' do
      expect do
        subject.invoke
      end.to change(user.connects, :count).by(1)
    end

    describe 'options hooks' do
      let(:i2p_option) { create(:i2p_option) }
      let(:proxy_option) { create(:proxy_option) }
      let(:country) { 'China' }
      let!(:node) { create(:proxy_node, country: country) }

      before { user.user_options.create!(option: i2p_option) }

      context 'user options are enabled' do
        before do
          user.user_options.create!(option: proxy_option, attrs: { country: country })
        end

        it 'assigns option parameters to connect' do
          expect(subject.invoke.option_attributes.class).to eq Hash
        end

        it 'parameters exist for each option' do
          expect(subject.invoke.option_attributes.size).to eq 2
        end
      end

      context 'user option is disabled' do
        before do
          user.user_options.create!(option: proxy_option, state: 'disabled', attrs: { country: country })
        end

        it 'assigns option parameters to connect' do
          expect(subject.invoke.option_attributes.class).to eq Hash
        end

        it 'parameters exist only for enabled user options' do
          expect(subject.invoke.option_attributes.size).to eq 1
        end
      end
    end

    it 'record has server hostname' do
      subject.invoke
      expect(Connect.last.hostname).to eq server.hostname
    end

    it 'record belongs to user' do
      subject.invoke
      expect(Connect.last.user_id).to eq user.id
    end
  end

  context 'action is disconnect' do
    let(:params) do
      Hash[
      login: user.vpn_login,
      hostname: server.hostname,
      action: 'disconnect',
      traffic_in: 100,
      traffic_out: 1150
    ]
    end

    it 'creates disconnect record' do
      expect do
        subject.invoke
      end.to change(user.disconnects, :count).by(1)
    end

    describe 'disconnect record' do
      before { subject.invoke }

      it 'has server hostname' do
        expect(Disconnect.last.hostname).to eq server.hostname
      end

      it 'belongs to user' do
        expect(Disconnect.last.user_id).to eq user.id
      end

      it 'has traffic in' do
        expect(Disconnect.last.traffic_in).to eq 100
      end

      it 'has traffic out' do
        expect(Disconnect.last.traffic_out).to eq 1150
      end
    end
  end
end
