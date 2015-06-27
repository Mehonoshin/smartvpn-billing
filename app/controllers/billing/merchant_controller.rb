class Billing::MerchantController < Billing::BaseController
  skip_before_filter :check_authorization, :verify_authenticity_token
  before_action :check_if_pay_system_is_enabled, only: [:result]

  def success
    redirect_to billing_root_path, notice: t('billing.payments.notices.success')
  end

  def fail
    redirect_to billing_root_path, notice: t('billing.payments.notices.fail')
  end

  private

  def check_if_pay_system_is_enabled
    if payment_id.present? && payment.pay_system.disabled?
      raise BillingException, 'pay system is not enabled'
    end
  end

  def payment
    Payment.find(payment_id)
  end
end
