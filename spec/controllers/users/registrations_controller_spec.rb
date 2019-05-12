# frozen_string_literal: true

require 'spec_helper'

describe Users::RegistrationsController do
  describe 'POST #create' do
    let!(:referrer) { create(:user) }
    let(:plan) { create(:plan) }
    let(:attrs) do
      Hash[email: 'user@email.com',
           password: '123456789',
           plan_id: plan.id,
           accept_agreement: '1']
    end

    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    context 'reflink set in params' do
      before do
        request.cookies['reflink'] = referrer.reflink
        post :create, params: { user: attrs }
      end

      it 'creates user' do
        expect(User.count).to eq 2
      end

      it 'user has referrer' do
        expect(User.last.referrer).not_to be_nil
      end

      it 'user is linked to referrer' do
        expect(User.last.referrer_id).to eq referrer.id
      end
    end

    context 'no reflink in params' do
      before do
        post :create, params: { user: attrs }
      end

      it 'creates user' do
        expect(User.count).to eq 2
      end

      it 'does not have referrer' do
        expect(User.last.referrer).to be_nil
      end
    end
  end
end
