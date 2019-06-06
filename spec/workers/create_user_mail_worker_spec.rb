# frozen_string_literal: true

require 'rails_helper'

describe CreateUserMailWorker do
  subject { described_class.new }

  context '#perform' do
    let(:user) { create(:user) }
    let(:server) { create(:server) }
    let!(:plan) { create(:plan) }
    let(:mailer) { double }

    before do
      plan.users << user
      plan.servers << server
    end

    it 'notifies user by email' do
      expect { subject.perform(user.id) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'will be run mail to user' do
      expect(UserConnectionConfigMailer)
        .to receive(:notify)
        .with(user: user).and_return(mailer)
      allow(mailer).to receive(:deliver_now)
      subject.perform(user.id)
    end
  end
end
