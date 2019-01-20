# frozen_string_literal: true

module Web
  module Admin
    class ChangeLocaleLinkCell < BaseCell
      def render
        content_tag :li, class: 'nav-item' do
          link_to name_link, url, method: :put, class: 'nav-link'
        end
      end

      private

      def name_link
        return :RU if locale_ru?

        :EN
      end

      def locale_ru?
        I18n.locale == :ru
      end

      def url
        return admin_locale_set_en_languages_path if locale_ru?

        admin_locale_set_ru_languages_path
      end
    end
  end
end
