# frozen_string_literal: true

require 'spec_helper'

describe RandomString do
  describe '::generate' do
    subject { RandomString }
    let(:first_string) { RandomString.generate }
    let(:second_string) { RandomString.generate }

    it 'returns new string on each call' do
      expect(first_string).not_to eq second_string
    end

    it 'has default length' do
      expect(first_string.length).to eq RandomString::DEFAULT_LENGTH
    end

    it 'builds string with setted length' do
      different_lenght_string = subject.generate(12)
      expect(different_lenght_string.length).to eq 12
    end
  end
end
