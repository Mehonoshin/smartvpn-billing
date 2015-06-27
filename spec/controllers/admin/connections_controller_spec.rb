require 'rails_helper'

describe Admin::ConnectionsController do
  subject { response }
  login_admin

  describe "GET #index" do
    before { get :index }

    it { should render_template :index }

    it "returns success status" do
      expect(subject.status).to eq 200
    end
  end

  describe "GET #active" do
    before { get :active }

    it { should render_template :active }

    it "returns success status" do
      expect(subject.status).to eq 200
    end

    it "loads active connections" do
      expect(assigns(:connections)).to eq Connection.active.to_a
    end
  end

  describe "GET #show" do
    let(:connection) { create(:connect) }

    before { get :show, id: connection.id }

    it { should be_success }
    it { should render_template :show }
    it { expect(response.status).to eq 200 }
  end
end
