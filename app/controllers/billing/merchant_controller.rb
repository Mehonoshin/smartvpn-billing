# frozen_string_literal: true

class Billing::MerchantController < Billing::BaseController
  skip_before_action :check_authorization, :verify_authenticity_token
  before_action :check_if_pay_system_is_enabled, only: [:result]

  def success
    redirect_to billing_root_path, notice: t('billing.payments.notices.success')
  end

  def fail
    redirect_to billing_root_path, notice: t('billing.payments.notices.fail')
  end

  private

  def check_if_pay_system_is_enabled
    raise BillingException, 'pay system is not enabled' if payment_id.present? && payment.pay_system.disabled?
  end

  def payment
    Payment.find(payment_id)
  end
end
