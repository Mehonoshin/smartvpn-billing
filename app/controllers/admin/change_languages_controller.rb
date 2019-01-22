# frozen_string_literal: true

class Admin
  class ChangeLanguagesController < Admin::BaseController
    def update
      set_session_and_redirect
    end

    private

    def set_session_and_redirect
      session[:locale] = I18n.locale
      redirect_to :back
    end
  end
end
