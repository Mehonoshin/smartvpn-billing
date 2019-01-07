# frozen_string_literal: true

require 'spec_helper'

describe Option do
  it { should validate_presence_of :name }
  it { should validate_presence_of :code }
  it { should have_and_belong_to_many(:plans) }
  it { should have_many(:users) }
  it { should have_many(:user_options) }

  describe '.state' do
    subject { described_class.new }

    context 'when new' do
      it 'has disabled state' do
        expect(subject.disabled?).to be true
      end
    end
  end

  describe '.default_attributes' do
    subject { build(:option, code: code) }

    context 'i2p' do
      let(:code) { 'i2p' }

      it 'returns empty hash' do
        expect(subject.default_attributes).to eq Hash[]
      end
    end

    context 'proxy' do
      let(:code) { 'proxy' }
      let(:country) { 'China' }
      let!(:node) { create(:proxy_node, country: country) }

      it 'returns empty hash' do
        expect(subject.default_attributes).to eq Hash[country: country]
      end
    end
  end

  describe '.hook' do
    let(:user) { nil }
    let(:hook) { subject.hook(user) }
    subject { build(:option, code: code) }

    context 'with hooks' do
      let(:code) { 'proxy' }

      it 'builds hook instance' do
        Options::Hooks::Proxy.expects(:new).with(user, subject)
        hook
      end

      it 'returns instance of hook object' do
        expect(hook.class).to eq Options::Hooks::Proxy
      end
    end

    context 'without hooks' do
      let(:code) { 'i2p' }

      it 'returns nil' do
        expect(hook).to eq nil
      end
    end
  end
end
