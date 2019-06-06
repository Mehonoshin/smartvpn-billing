# frozen_string_literal: true

require 'spec_helper'

describe NewsletterManager do
  subject { described_class.new }

  describe '#add_to_list' do
    let(:email) { 'test@email.com' }

    context 'list is all' do
      let(:list_name) { :all }

      it 'calls Mailchimp api' do
        FakeWeb.register_uri(:post, 'https://key.api.mailchimp.com/2.0/lists/subscribe', body: '{}')
        subject.add_to_list(email, list_name)
      end
    end

    context 'non-existing list' do
      let(:list_name) { :non_existing }

      it 'raises error' do
        expect do
          subject.add_to_list(email, list_name)
        end.to raise_error SmartvpnException, 'Email list not defined'
      end
    end
  end
end
