# frozen_string_literal: true

class Admin
  module Locale
    class SetRuLanguagesController < Admin::Locale::BaseController
      def update
        I18n.locale = :ru
        set_session_and_redirect
      end
    end
  end
end
