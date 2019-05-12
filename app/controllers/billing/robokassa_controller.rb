# frozen_string_literal: true

# This controller contains endpoints for Robokassa paysystem HTTP callbacks,
# that notifies system about incoming payments.
class Billing::RobokassaController < Billing::MerchantController
  include OffsitePayments::Integrations

  before_action :create_notification

  def result
    if @notification.acknowledge
      render plain: 'Done'
      payment.accept!
    else
      raise 'Invalid robokassa notification'
    end
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, secret: ENV['ROBOKASSA_SECRET2'])
  end

  def payment_id
    params['InvId']
  end
end
