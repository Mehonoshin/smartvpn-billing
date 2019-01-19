# frozen_string_literal: true

require 'rails_helper'

describe ServerConfigBuilder do
  let(:server) { create(:server) }
  subject { described_class.new(server: server) }

  describe '#to_text' do
    it 'returns ServerConfig text' do
      expect(subject.to_text.class).to eq String
    end

    describe 'protocol' do
      it 'contains protocol' do
        expect(subject.to_text).to include server.protocol
      end

      it 'replaces old protocol' do
        expect(subject.to_text).not_to include 'unknown_proto'
      end
    end

    describe 'host' do
      it 'contains host' do
        expect(subject.to_text).to include server.hostname
      end

      it 'replaces old host' do
        expect(subject.to_text).not_to include 'unknown_host'
      end
    end

    describe 'port' do
      it 'contains port' do
        expect(subject.to_text).to include server.port.to_s
      end

      it 'replaces old port' do
        expect(subject.to_text).not_to include 'unknown_port'
      end
    end
  end
end
