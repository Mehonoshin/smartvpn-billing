# frozen_string_literal: true

require 'spec_helper'

describe Option::Deactivator do
  let(:option) { create(:active_option) }
  let(:user) { create(:user) }

  before do
    user.options << option
  end

  describe '.run' do
    it 'deactivates option for user' do
      expect do
        described_class.run(user, option.id)
      end.to change(user.options, :count).by(-1)
    end
  end
end
