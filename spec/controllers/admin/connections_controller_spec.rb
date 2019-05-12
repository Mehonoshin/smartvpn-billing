# frozen_string_literal: true

require 'rails_helper'

describe Admin::ConnectionsController do
  subject { response }

  login_admin

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to render_template :index }

    it 'returns success status' do
      expect(subject.status).to eq 200
    end
  end

  describe 'GET #active' do
    before { get :active }

    it { is_expected.to render_template :active }

    it 'returns success status' do
      expect(subject.status).to eq 200
    end

    it 'loads active connections' do
      expect(assigns(:connections)).to eq Connection.active.to_a
    end
  end

  describe 'GET #show' do
    let(:connection) { create(:connect) }

    before { get :show, params: { id: connection.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :show }
    it { expect(response.status).to eq 200 }
  end
end
