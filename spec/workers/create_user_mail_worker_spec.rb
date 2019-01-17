# frozen_string_literal: true

require 'rails_helper'

describe CreateUserMailWorker do
  subject { described_class.new }

  context '#perform' do
    let(:user) { create(:user) }
    let(:server) { create(:server) }
    let!(:plan) { create(:plan, users: [user], servers: [server]) }
    let(:params) { { user_id: user.id, crypted_password: '123456' }.as_json }
    let(:mailer) { double }

    it 'notifies user by email' do
      expect { subject.perform(params) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'will be run mail to user' do
      expect(UserConnectionConfigMailer)
        .to receive(:notify)
        .with(user: user, crypted_password: params['crypted_password']).and_return(mailer)
      allow(mailer).to receive(:deliver_now)
      subject.perform(params)
    end
  end
end
