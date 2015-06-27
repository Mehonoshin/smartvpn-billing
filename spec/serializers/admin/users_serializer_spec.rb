require 'spec_helper'

describe Admin::UsersSerializer do
  describe '#emails' do
    let(:users) { User.all }
    let(:serializer) { described_class.new(users, :csv) }

    before do
      create_list(:user, 2)
    end

    it 'returns emails' do
      expect(serializer.emails).to eq users.map(&:email).join(',')
    end
  end
end
