# frozen_string_literal: true

require 'spec_helper'

describe Billing::ReferrersController do
  login_user
  subject { response }

  describe 'GET #index' do
    before { get :index }
    it { should be_success }
    it { should render_template :index }
  end
end
