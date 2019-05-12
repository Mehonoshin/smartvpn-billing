# frozen_string_literal: true

require 'spec_helper'

describe Admin::PaySystemsController do
  context 'logged in as user' do
    login_user

    it 'does not allow to be accessed by user' do
      get :index
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'not logged in' do
    it 'does not allow to be accessed by guest' do
      get :index
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'logged in as admin' do
    login_admin

    describe 'GET #index' do
      before { get :index }

      it 'renders pay_system list' do
        expect(response).to render_template :index
      end

      it 'returns success status' do
        expect(response.status).to eq 200
      end
    end

    describe 'GET #show' do
      let!(:pay_system) { create :pay_system }

      before { get :show, params: { id: pay_system.id } }

      it 'renders template' do
        expect(response).to render_template :show
      end

      it 'returns success status' do
        expect(response.status).to eq 200
      end
    end

    describe 'GET #new' do
      before { get :new }

      it 'renders form' do
        expect(response).to render_template :new
      end

      it 'returns success status' do
        expect(response.status).to eq 200
      end
    end

    describe 'POST #create' do
      context 'valid attributes' do
        let(:attrs) { attributes_for(:pay_system) }

        it 'creates new pay_system' do
          expect do
            post :create, params: { pay_system: attrs }
          end.to change(PaySystem, :count).by(1)
        end

        it 'redirects to pay_systems list' do
          post :create, params: { pay_system: attrs }
          expect(response).to redirect_to admin_pay_systems_path
        end
      end

      context 'invalid attributes' do
        let(:attrs) { Hash[name: nil, code: nil] }

        it 'renders pay_system form' do
          post :create, params: { pay_system: attrs }
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      let!(:pay_system) { create(:pay_system) }

      it 'renders edit pay_system page' do
        get :edit, params: { id: pay_system.id }
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      let!(:pay_system) { create(:pay_system) }

      context 'valid attrs' do
        let(:attrs) { Hash[name: 'new_name'] }

        it 'updates pay_system' do
          new_pay_system = create(:pay_system)
          put :update, params: { id: new_pay_system.id, pay_system: attrs }
          expect(new_pay_system.reload.name).to eq attrs[:name]
        end

        it 'redirects to pay_systems list' do
          put :update, params: { id: pay_system.id, pay_system: attrs }
          expect(response).to redirect_to admin_pay_systems_path
        end
      end

      context 'invalid attrs' do
        let(:attrs) { Hash[name: nil] }

        it 'renders edit form' do
          put :update, params: { id: pay_system.id, pay_system: attrs }
          expect(response).to render_template :edit
        end
      end
    end
  end
end
