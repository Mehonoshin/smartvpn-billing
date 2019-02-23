# frozen_string_literal: true

class Billing::ReferrersController < Billing::BaseController
  def index
    @referrals = current_user.referrals
    @account = current_user.referrer_account
    @operations = @account.operations
  end
end
