# frozen_string_literal: true

class Admin
  module Locale
    class SetEnLanguagesController < Admin::Locale::BaseController
      def update
        I18n.locale = :en
        set_session_and_redirect
      end
    end
  end
end
