require 'spec_helper'

describe UserOption do
  subject { build(:user_option) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:option_id) }
  it { should belong_to :user }
  it { should belong_to :option }

  it 'is enabled' do
    expect(subject.enabled?).to be true
  end

  describe 'enabled scope' do
    before do
      create_list(:user_option, 3)
      create(:user_option, :disabled)
    end

    it 'returns only enabled options' do
      expect(described_class.enabled.size).to eq 3
    end
  end

  describe 'toggle!' do
    before { option.toggle! }

    context 'enabled' do
      let(:option) { create(:user_option) }

      it 'makes disabled' do
        expect(option.disabled?).to be true
      end
    end

    context 'disabled' do
      let(:option) { create(:user_option, :disabled) }

      it 'makes enabled' do
        expect(option.enabled?).to be true
      end
    end
  end
end
