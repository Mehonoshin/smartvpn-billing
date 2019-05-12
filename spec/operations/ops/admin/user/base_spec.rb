# frozen_string_literal: true

require 'rails_helper'

describe Ops::Admin::User::Base do
  subject { described_class.new(params: params) }

  let(:plan) { create(:plan) }
  let(:params) do
    {
      email: 'user@gmail.com',
      password: '123456',
      password_confirmation: '123456',
      plan_id: plan.id
    }
  end

  it 'returns raise' do
    expect { subject.call }.to raise_error NotImplementedError
  end
end
