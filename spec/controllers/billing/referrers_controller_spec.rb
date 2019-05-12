# frozen_string_literal: true

require 'spec_helper'

describe Billing::ReferrersController do
  login_user
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end
end
