require 'spec_helper'

describe Option::Deactivator do
  let(:option) { create(:active_option) }
  let(:user) { create(:user) }

  before do
    user.options << option
  end

  describe '.run' do
    it 'deactivates option for user' do
      expect {
        described_class.run(user, option.id)
      }.to change(user.options, :count).by(-1)
    end
  end
end
