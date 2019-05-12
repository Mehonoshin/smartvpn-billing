# frozen_string_literal: true

require 'spec_helper'

describe Admin::ServersController do
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

      it 'renders server list' do
        expect(response).to render_template :index
      end

      it 'returns success status' do
        expect(response.status).to eq 200
      end
    end

    describe 'GET #show' do
      let!(:server) { create :server }

      before { get :show, params: { id: server.id } }

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
        let(:attrs) { attributes_for(:server) }

        it 'creates new server' do
          expect do
            post :create, params: { server: attrs }
          end.to change(Server, :count).by(1)
        end

        it 'redirects to servers list' do
          post :create, params: { server: attrs }
          expect(response).to redirect_to admin_servers_path
        end
      end

      context 'invalid attributes' do
        let(:attrs) { Hash[hostname: nil, ip_address: nil] }

        it 'renders server form' do
          post :create, params: { server: attrs }
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      let!(:server) { create(:server) }

      it 'renders edit server page' do
        get :edit, params: { id: server.id }
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      let!(:server) { create(:server) }

      context 'valid attrs' do
        let(:attrs) { Hash[hostname: 'new_hostname.smartvpn.biz'] }

        it 'updates server' do
          new_server = create(:server)
          put :update, params: { id: new_server.id, server: attrs }
          expect(new_server.reload.hostname).to eq attrs[:hostname]
        end

        it 'redirects to servers list' do
          put :update, params: { id: server.id, server: attrs }
          expect(response).to redirect_to admin_servers_path
        end
      end

      context 'invalid attrs' do
        let(:attrs) { Hash[hostname: nil] }

        it 'renders edit form' do
          put :update, params: { id: server.id, server: attrs }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:server) { create(:server) }

      it 'removes server' do
        expect do
          delete :destroy, params: { id: server.id }
        end.to change(Server, :count).by(-1)
      end
    end

    describe 'GET #generate_config' do
      let!(:server) { create(:server) }
      let!(:config) { ServerConfigBuilder.new(server: server).to_text }

      it 'calls config builder' do
        allow_any_instance_of(ServerConfigBuilder).to receive(:to_text).and_return(config)
        get :generate_config, params: { id: server.id }
      end

      it 'sends config to download' do
        get :generate_config, params: { id: server.id }
        expect(response.header['Content-Type']).to eq 'application/octet-stream'
      end
    end
  end
end
