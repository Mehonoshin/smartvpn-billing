# frozen_string_literal: true

require 'rails_helper'

describe UserConnectionConfigMailer do
  describe '#notify' do
    subject { described_class.notify(user: user) }

    let!(:user) { create(:user) }
    let!(:server) { create(:server) }
    let!(:plan) { create(:plan) }
    let(:server_config) { ServerConfigBuilder.new(server: server).to_text }

    before do
      plan.users << user
      plan.servers << server
    end

    its(:subject) { is_expected.to eq I18n.t('mailers.user_connection_config_mailer.subject') }
    its(:to) { is_expected.to eq [user.email] }
    its(:from) { is_expected.to eq [ENV['EMAIL_FROM']] }

    it 'email have 1 attachment' do
      expect(subject.attachments.count).to eq 1
    end

    it 'attachment name' do
      expect(subject.attachments.first.filename).to eq "#{server.hostname}.ovpn"
    end

    it 'renders vpn username' do
      expect(subject.body.encoded).to match(user.vpn_login)
    end

    it 'renders vpn password' do
      expect(subject.body.encoded).to match(user.vpn_password)
    end
  end
end
