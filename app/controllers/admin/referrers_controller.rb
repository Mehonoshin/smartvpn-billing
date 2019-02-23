# frozen_string_literal: true

class Admin::ReferrersController < Admin::BaseController
  def index
    @referrers = User.active_referrers
  end
end
