# frozen_string_literal: true

class Admin
  module Locale
    class BaseController < Admin::BaseController
      private

      def set_session_and_redirect
        session[:locale] = I18n.locale
        redirect_to :back
      end
    end
  end
end
