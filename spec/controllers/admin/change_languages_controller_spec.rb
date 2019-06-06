# frozen_string_literal: true

require 'rails_helper'

describe Admin::ChangeLanguagesController do
  login_admin

  describe 'PUT #update' do
    before do
      request.env['HTTP_REFERER'] = 'where_i_came_from'
      put :update, params: { locale: :ru }
    end

    it 'session locale will be set to RU' do
      expect(session[:locale]).to eq :ru
    end

    it 'current locale will be set to RU' do
      expect(I18n.locale).to eq :ru
    end

    it 'will be redirect to back' do
      expect(response).to redirect_to 'where_i_came_from'
    end
  end
end
