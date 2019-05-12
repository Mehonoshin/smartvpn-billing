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

    it 'will be created user' do
      expect { subject.call }.to change(User, :count).by(1)
    end

    it 'returns success result' do
      expect(CreateUserMailWorker).to receive(:perform_async).with(any_args)
      subject.call
    end

    it 'adds email task to queue' do
      expect { subject.call }.to change(CreateUserMailWorker.jobs, :size).by(1)
    end
  end

  context 'invalid params' do
    let(:params) do
      {
        email: 'user@gmail.com',
        password: '123456',
        password_confirmation: '12345678',
        plan_id: plan.id
      }
    end

    it 'returns failed result' do
      expect(subject.call[:success]).to eq false
    end

    it 'will be created user' do
      expect { subject.call }.to change(User, :count).by(0)
    end

    it 'returns success result' do
      expect(CreateUserMailWorker).not_to receive(:perform_async).with(any_args)
      subject.call
    end

    it 'adds email task to queue' do
      expect { subject.call }.not_to(change(CreateUserMailWorker.jobs, :size))
    end
  end
end
