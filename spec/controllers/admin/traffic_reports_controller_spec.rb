# frozen_string_literal: true

require 'spec_helper'

describe Admin::TrafficReportsController do
  login_admin
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end

  describe 'GET #users' do
    before { get :users }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :users }
  end

  describe 'GET #date' do
    before { get :date }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :date }
  end

  describe 'GET #servers' do
    before { get :servers }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :servers }
  end
end
