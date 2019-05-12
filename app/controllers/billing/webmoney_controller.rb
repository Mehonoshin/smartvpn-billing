# frozen_string_literal: true

# This controller contains endpoints for Webmoney paysystem HTTP callbacks,
# that notifies system about incoming payments.
class Billing::WebmoneyController < Billing::MerchantController
  include OffsitePayments::Integrations

  before_action :create_notification

  def result
    if @notification.key_present?
      if @notification.recognizes?
        if @notification.acknowledge
          render plain: 'Done'
          payment.accept!
        else
          raise 'Invalid webmoney verification key'
        end
      else
        raise 'Undefined transaction_item_id'
      end
    else
      render plain: 'YES'
    end
  end

  def create_notification
    @notification = Webmoney::Notification.new(request.raw_post, secret: ENV['WEBMONEY_SECRET'])
  end

  def payment_id
    params['LMI_PAYMENT_NO']
  end
end
