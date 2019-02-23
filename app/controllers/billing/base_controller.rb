# frozen_string_literal: true

class Billing::BaseController < ApplicationController
  layout 'billing'

  before_action :check_authorization

  private

  def check_authorization
    raise UnauthorizedException, I18n.t('global.authorize_please') unless current_user
  end
end
