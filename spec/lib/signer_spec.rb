# frozen_string_literal: true

require 'spec_helper'

describe Signer do
  subject { described_class }

  describe '::sign_hash' do
    subject { described_class.sign_hash(hash, key) }

    let(:hash) { Hash[a: 2, b: 1, c: 3] }
    let(:key) { '456' }

    it 'joins hash values without character' do
      expect(subject).not_to eq Digest::MD5.hexdigest("#{hash.values.sort}#{key}")
    end

    it 'sorts hash values' do
      expect(subject).not_to eq Digest::MD5.hexdigest("#{hash.values.join}#{key}")
    end

    it 'appends secret key to values' do
      expect(subject).not_to eq Digest::MD5.hexdigest(hash.values.sort.join.to_s)
    end

    it 'counts md5 of ruby hash' do
      expect(subject).to eq Digest::MD5.hexdigest("#{hash.values.sort.join}#{key}")
    end
  end

  describe '::hashify_string' do
    it 'returns md5 hash of string' do
      result = subject.hashify_string('mystring')
      expect(result).to eq Digest::MD5.hexdigest('mystring')
    end
  end
end
