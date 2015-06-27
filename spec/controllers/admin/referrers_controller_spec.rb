require 'spec_helper'

describe Admin::ReferrersController do
  subject { response }

  it_behaves_like 'requires admin access', :get, :index

  context 'is admin' do
    login_admin

    describe 'GET #index' do
      before { get :index }

      it { should be_success }
      it { should render_template :index }
    end
  end
end
