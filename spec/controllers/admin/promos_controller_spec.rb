# frozen_string_literal: true

require 'spec_helper'

describe Admin::PromosController do
  subject { response }

  context 'logged in as user' do
    login_user

    it 'does not allow to be accessed by user' do
      get :index
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'logged in as admin' do
    login_admin

    describe 'GET #index' do
      before { get :index }

      it { is_expected.to render_template :index }
      it { expect(subject.status).to eq 200 }
    end

    describe 'GET #new' do
      before { get :new }

      it { is_expected.to render_template :new }
      it { expect(subject.status).to eq 200 }
    end

    describe 'POST #create' do
      context 'valid params' do
        let(:attrs) { Hash[name: 'new name', type: 'withdrawal', promoter_type: 'discount'] }

        it 'redirects to promos path' do
          post :create, params: { promo: attrs }
          expect(subject).to redirect_to edit_admin_promo_path(Promo.last)
        end

        it 'creates new promo' do
          expect do
            post :create, params: { promo: attrs }
          end.to change(Promo, :count).by(1)
        end
      end

      context 'invalid params' do
        let(:attrs) { Hash[name: nil] }

        it 'renders new template' do
          post :create, params: { promo: attrs }
          expect(subject).to render_template :new
        end

        it 'does not create promo' do
          expect do
            post :create, params: { promo: attrs }
          end.not_to change(Promo, :count)
        end
      end
    end

    describe 'GET #edit' do
      let(:promo) { create(:promo) }

      before { get :edit, params: { id: promo.id } }

      it { is_expected.to render_template :edit }
      it { expect(subject.status).to eq 200 }
    end

    describe 'PUT #update' do
      let!(:promo) { create(:promo) }

      context 'valid params' do
        let(:attrs) { Hash[name: 'new name', type: 'withdrawal', promoter_type: 'discount'] }

        it 'redirects to edit page' do
          put :update, params: { promo: attrs, id: promo.id }
          expect(subject).to redirect_to edit_admin_promo_path(promo)
        end

        it 'updates promo' do
          put :update, params: { promo: attrs, id: promo.id }
          expect(promo.reload.name).to eq attrs[:name]
        end
      end

      context 'invalid params' do
        let(:attrs) { Hash[name: 'new name', type: nil, promoter_type: 'discount'] }

        it 'renders edit form' do
          put :update, params: { promo: attrs, id: promo.id }
          expect(subject).to render_template :edit
        end

        it 'does not update promo' do
          put :update, params: { promo: attrs, id: promo.id }
          expect(promo.reload.name).not_to eq attrs[:name]
        end
      end
    end
  end
end
