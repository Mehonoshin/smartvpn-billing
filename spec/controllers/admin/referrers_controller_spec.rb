# frozen_string_literal: true

require 'spec_helper'

describe Admin::ReferrersController do
  subject { response }

  it_behaves_like 'requires admin access', :get, :index

  context 'is admin' do
    login_admin

    describe 'GET #index' do
      before { get :index }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
    end
  end
end
