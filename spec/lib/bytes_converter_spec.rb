# frozen_string_literal: true

require 'spec_helper'

describe BytesConverter do
  describe '#bytes_to_gigabytes' do
    subject { described_class.bytes_to_gigabytes(bytes) }

    let(:bytes) { 2_147_483_658 }
    let(:gbytes) { 2 }

    it 'converts to gbytes' do
      expect(subject).to eq gbytes
    end
  end

  describe '#prettify_float' do
    subject { described_class.prettify_float(float) }

    context 'zero float' do
      let(:float) { 0.123456 }

      it 'prettifys' do
        expect(subject).to eq 0.1235
      end
    end

    context 'single float' do
      let(:float) { 1.123456 }

      it 'prettifys' do
        expect(subject).to eq 1.123
      end
    end

    context 'double float' do
      let(:float) { 12.123456 }

      it 'prettifys' do
        expect(subject).to eq 12.12
      end
    end

    context 'triple float' do
      let(:float) { 123.123456 }

      it 'prettifys' do
        expect(subject).to eq 123.1
      end
    end

    context 'five float' do
      let(:float) { 12_345.123456 }

      it 'prettifys' do
        expect(subject).to eq 12_345.1
      end
    end
  end
end
