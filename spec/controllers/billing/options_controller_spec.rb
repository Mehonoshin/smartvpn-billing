# frozen_string_literal: true

require 'spec_helper'

describe Billing::OptionsController do
  login_user
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end

  describe 'POST #create' do
    let!(:option) { create(:active_option) }
    let(:option_code) { option.code }

    before do
      allow(Option::Activator).to receive(:run).with(@user, option_code).and_return(activation_result)
      post :create, params: { code: option_code }
    end

    context 'success' do
      let(:activation_result) { true }

      it 'redirests to options list' do
        expect(response).to redirect_to billing_options_path
      end

      it 'displays success message' do
        expect(flash[:notice]).to include I18n.t('billing.options.notices.activated')
      end
    end

    context 'failure' do
      let(:activation_result) { false }

      it 'redirests to options list' do
        expect(response).to redirect_to billing_options_path
      end

      it 'displays failure message' do
        expect(flash[:alert]).to include I18n.t('billing.options.notices.not_activated')
      end
    end
  end

  describe 'PUT #update' do
    let(:option) { create(:proxy_option) }
    let(:old_attrs) { Hash[country: 'China'] }
    let(:new_attrs) { Hash[country: 'Russia'] }
    let!(:user_option) do
      create(:user_option, state: 'enabled',
                           attrs: old_attrs,
                           user: @user,
                           option: option)
    end

    before { put :update, params: { id: option.id, option_attributes: new_attrs } }

    it 'changes attributes' do
      expect(user_option.reload.attrs['country']).to eq 'Russia'
    end
  end

  describe 'PUT #toggle' do
    let(:option) { create(:proxy_option) }
    let!(:user_option) { create(:user_option, state: 'enabled', user: @user, option: option) }

    it 'calles toggle! on option' do
      allow_any_instance_of(UserOption).to receive(:toggle!)
      put :toggle, params: { id: option.id }
    end
  end
end
