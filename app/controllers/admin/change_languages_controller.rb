# frozen_string_literal: true

class Admin
  class ChangeLanguagesController < Admin::BaseController
    def update
      set_session_and_redirect
    end

    private

    def set_session_and_redirect
      session[:locale] = I18n.locale
      redirect_back fallback_location: admin_change_languages_path(locale: session[:locale])
    end
  end
end
