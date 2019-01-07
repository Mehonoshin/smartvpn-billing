# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :allow_only_admin
  layout 'admin'

  def allow_only_admin
    raise AdminAccessDeniedException unless admin_signed_in?
  end
end
