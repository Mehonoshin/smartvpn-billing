# frozen_string_literal: true

require 'spec_helper'

describe Admin::OptionsController do
  subject { response }

  login_admin

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    context 'valid attrs' do
      let(:attrs) { attributes_for(:option) }

      it 'creates new option' do
        expect do
          post :create, params: { option: attrs }
        end.to change(Option.all, :count).by(1)
      end

      it 'redirects to options path' do
        post :create, params: { option: attrs }
        expect(response).to redirect_to admin_options_path
      end
    end

    context 'invalid attrs' do
      let(:attrs) { Hash[name: nil, code: nil] }

      it 'renders new form' do
        post :create, params: { option: attrs }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:option) { create(:option) }

    before { get :edit, params: { id: option.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :edit }
  end

  describe 'PUT #update' do
    let!(:option) { create(:option) }

    context 'valid attrs' do
      let(:attrs) { Hash[name: 'new_name', code: 'new_code'] }

      it 'updates option' do
        put :update, params: { id: option.id, option: attrs }
        expect(option.reload.name).to eq attrs[:name]
      end

      it 'redirects to options path' do
        put :update, params: { id: option.id, option: attrs }
        expect(subject).to redirect_to admin_options_path
      end
    end

    context 'invalid attrs' do
      let(:attrs) { Hash[code: nil] }

      it 'renders edit form' do
        put :update, params: { id: option.id, option: attrs }
        expect(subject).to render_template :edit
      end
    end
  end
end
