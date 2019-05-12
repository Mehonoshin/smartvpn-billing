# frozen_string_literal: true

require 'spec_helper'

describe TransactionDecorator do
  subject { described_class.new(transaction) }

  let(:model) { create(:payment) }
  let(:transaction) { Transaction.new(model.id, model) }

  it 'delegates id to model' do
    expect(subject.id).to eq transaction.id
  end

  it 'returns amount with currency code' do
    expect(subject.amount).to include 'USD'
  end

  describe '#user' do
    it 'returns link' do
      expect(subject.user).to include 'href'
    end

    it 'user email is link anchor' do
      expect(subject.user).to include model.user.email
    end
  end

  context 'model is payment' do
    it 'returns amount with positive sign' do
      expect(subject.amount).to include '+'
    end

    it 'returns description with pay system name' do
      expect(subject.description).to include model.pay_system.name
    end
  end

  context 'model is withdrawal' do
    let(:model) { create(:withdrawal) }

    it 'returns amount with negative sign' do
      expect(subject.amount).to include '-'
    end

    it 'returns description with plan name' do
      expect(subject.description).to include model.plan.name
    end
  end
end
