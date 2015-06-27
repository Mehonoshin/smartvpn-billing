require 'spec_helper'

describe Admin::TrafficReportsController do
  login_admin
  subject { response }

  describe "GET #index" do
    before { get :index }

    it { should be_success }
    it { should render_template :index }
  end

  describe "GET #users" do
    before { get :users}

    it { should be_success }
    it { should render_template :users }
  end

  describe "GET #date" do
    before { get :date }

    it { should be_success }
    it { should render_template :date }
  end

  describe "GET #servers" do
    before { get :servers}

    it { should be_success }
    it { should render_template :servers }
  end
end
