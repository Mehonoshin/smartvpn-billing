# frozen_string_literal: true

require 'spec_helper'

describe ReferrersController do
  describe 'GET #set_referrer' do
    let(:user) { create(:user) }

    before { get :set_referrer, params: { code: user.reflink } }

    it 'sets reflink to cookie' do
      expect(response.cookies['reflink']).to eq user.reflink
    end

    it 'redirects to index page' do
      expect(response).to redirect_to root_path
    end
  end
end
