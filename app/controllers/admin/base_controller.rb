# frozen_string_literal: true

class Admin
  class BaseController < ApplicationController
    before_action :allow_only_admin, :set_locale
    layout 'admin'

    private

    def allow_only_admin
      raise AdminAccessDeniedException unless admin_signed_in?
    end

    def set_locale
      I18n.locale = current_locale
    end

    def current_locale
      params[:locale] ||
        session[:locale] ||
        I18n.default_locale
    end
  end
end
