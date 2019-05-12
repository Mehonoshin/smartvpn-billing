# frozen_string_literal: true

require 'spec_helper'

describe Option::Activator do
  subject { described_class }

  let!(:option) { create(:active_option) }

  before { allow_any_instance_of(subject).to receive(:activation_price).and_return(1) }

  describe '.run' do
    let!(:user) { create(:user_with_balance) }

    context 'option permitted for users plan' do
      before { user.plan.options << option }

      context 'user has enough funds' do
        it 'activates option for user' do
          expect do
            subject.run(user, option.code)
          end.to change(user.options, :count).by(1)
        end

        it 'returns true' do
          expect(subject.run(user, option.code)).to eq true
        end
      end

      context 'user does not have enough funds' do
        let(:user) { create(:user, balance: 0) }

        it 'does not activate option for user' do
          expect do
            subject.run(user, option.code)
          end.to change(user.options.reload, :count).by(0)
        end

        it 'returns false' do
          expect(subject.run(user, option.code)).to eq false
        end
      end
    end

    context 'option is not permitted for users plan' do
      it 'does not activate option' do
        expect do
          subject.run(user, option.code)
        end.to change(user.options, :count).by(0)
      end

      it 'returns false' do
        expect(subject.run(user, option.code)).to eq false
      end
    end
  end
end
