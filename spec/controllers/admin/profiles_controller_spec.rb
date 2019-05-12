# frozen_string_literal: true

require 'spec_helper'

describe Admin::ProfilesController do
  context 'logged in as user' do
    login_user

    it 'does not allow to be accessed by user' do
      get :edit
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'not logged in' do
    it 'does not allow to be accessed by guest' do
      get :edit
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'logged in as admin' do
    let!(:admin) { create(:admin, password: '1234567') }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in admin
    end

    describe 'GET #edit' do
      before { get :edit }

      it 'renders edit profile page' do
        expect(response).to render_template :edit
      end

      it 'returns success result' do
        expect(response.status).to eq 200
      end
    end

    describe 'PUT #update' do
      let!(:old_password) { admin.encrypted_password }

      before { put :update, params: { admin: params } }

      context 'valid params' do
        let(:params) do
          Hash[
            current_password: '1234567',
            password: '12345678',
            password_confirmation: '12345678'
          ]
        end

        it 'updates password' do
          expect(admin.reload.encrypted_password).not_to eq old_password
        end

        it 'redirects to edit' do
          expect(response).to redirect_to edit_admin_profile_path
        end
      end

      context 'invalid params' do
        let(:params) { Hash[current_password: nil] }

        it 'renders edit form' do
          expect(response).to render_template :edit
        end

        it 'not updates password' do
          expect(admin.reload.encrypted_password).to eq old_password
        end
      end
    end
  end
end
