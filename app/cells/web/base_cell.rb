# frozen_string_literal: true

module Web
  # This base class includes view helpers
  class BaseCell
    include Rails.application.routes.url_helpers
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Context
  end
end
