# frozen_string_literal: true

require 'spec_helper'

describe Admin::OptionsDecorator do
  subject { described_class.new(object) }

  let(:object) { create(:option) }

  describe 'state' do
    it 'has state class' do
      expect(subject.state).to include 'state'
    end

    it 'wrapped by span' do
      expect(subject.state).to include 'span'
    end

    context 'active' do
      before { object.activate! }

      it '.state' do
        expect(subject.state).to include 'active'
      end
    end

    context 'disabled' do
      it '.state' do
        expect(subject.state).to include 'disabled'
      end
    end
  end
end
