# frozen_string_literal: true

require 'rails_helper'

describe Ops::Admin::User::Create do
  subject { described_class.new(params: params) }
  let!(:plan) { create(:plan) }

  context 'valid params' do
    let(:params) do
      {
        email: 'user@gmail.com',
        password: '123456',
        password_confirmation: '123456',
        plan_id: plan.id
      }
    end

    it 'returns success result' do
      expect(subject.call).to eq(success: true, user: User.last)
    end

    it 'returns success result' do
      expect(CreateUserMailWorker).to receive(:perform_async).with(any_args)
      subject.call
    end
  end
end
