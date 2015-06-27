class Admin::BaseController < ApplicationController
  before_action :allow_only_admin
  layout "admin"

  def allow_only_admin
    unless admin_signed_in?
      raise AdminAccessDeniedException
    end
  end
end
