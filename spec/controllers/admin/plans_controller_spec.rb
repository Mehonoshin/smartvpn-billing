# frozen_string_literal: true

require 'spec_helper'

describe Admin::PlansController do
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

      it 'renders plan list' do
        expect(response).to render_template :index
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
        let(:attrs) { attributes_for(:plan) }

        it 'creates new plan' do
          expect do
            post :create, params: { plan: attrs }
          end.to change(Plan, :count).by(1)
        end

        it 'redirects to plans list' do
          post :create, params: { plan: attrs }
          expect(response).to redirect_to admin_plans_path
        end
      end

      context 'invalid attributes' do
        let(:attrs) { Hash[name: nil, price: nil] }

        it 'renders plan form' do
          post :create, params: { plan: attrs }
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      let!(:plan) { create(:plan) }

      it 'renders edit plan page' do
        get :edit, params: { id: plan.id }
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      let!(:plan) { create(:plan) }

      context 'valid attrs' do
        let(:attrs) { Hash[name: 'new_name'] }

        it 'updates plan' do
          new_plan = create(:plan)
          put :update, params: { id: new_plan.id, plan: attrs }
          expect(new_plan.reload.name).to eq attrs[:name]
        end

        it 'redirects to plans list' do
          put :update, params: { id: plan.id, plan: attrs }
          expect(response).to redirect_to admin_plans_path
        end
      end

      context 'invalid attrs' do
        let(:attrs) { Hash[name: nil] }

        it 'renders edit form' do
          put :update, params: { id: plan.id, plan: attrs }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:plan) { create(:plan) }

      it 'removes plan' do
        expect do
          delete :destroy, params: { id: plan.id }
        end.to change(Plan, :count).by(-1)
      end
    end
  end
end
