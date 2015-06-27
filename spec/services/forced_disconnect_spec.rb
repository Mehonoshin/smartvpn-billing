require 'spec_helper'

describe ForcedDisconnect do
  let(:user)   { create(:user) }
  let(:server) { create(:server) }
  subject      { described_class.new(user) }

  describe '#invoke' do
    context 'connected' do
      let!(:connect) { create(:connect, user: user, server: server) }

      it 'creates disconnect' do
        expect {
          subject.invoke
        }.to change(Disconnect, :count).by(1)
      end
    end

    context 'not connected' do
      it 'does not create disconnect' do
        expect {
          subject.invoke
        }.not_to change(Disconnect, :count)
      end
    end
  end
end
