# frozen_string_literal: true

require 'spec_helper'

describe OptionAttributeDecorator do
  subject { described_class.new(name, values, current_value) }

  let(:name) { 'country' }
  let(:current_value) { 'Russia' }

  describe '.render' do
    context 'select' do
      let(:values) do
        {
          type: :select, value: ['Russia']
        }
      end

      it 'renders select tag' do
        expect(subject.render).to include 'select'
      end

      it 'includes values' do
        expect(subject.render).to include values[:value].first
      end

      it 'input has according name' do
        expect(subject.render).to include "name=\"#{name}\""
      end
    end
  end
end
