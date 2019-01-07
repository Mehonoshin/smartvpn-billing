# frozen_string_literal: true

require 'spec_helper'

describe Currencies::CourseConverter do
  subject { described_class.new(currency_from: 'eur', currency_to: 'usd', amount: 100) }

  describe 'amount conversion' do
    let(:course) { 2 }
    before { Currencies::Course.any_instance.stubs(:get).returns(course) }

    it 'devides currency by amount' do
      expect(subject.convert_amount).to eq 200
    end

    context 'course is string' do
      let(:course) { '2' }

      it 'converts string to int' do
        expect(subject.convert_amount).to eq 200
      end
    end
  end
end
