# frozen_string_literal: true

class Billing::PaypalController < Billing::MerchantController
  include OffsitePayments::Integrations

  def result
    if notitication.acknowledge
      if notification.complete? && (payment.amount == notification.amount)
        payment.accept!
      else
        raise "Failed to verify Paypal's notification, please investigate"
      end
    end
    render :nothing
  end

  private

  def notitication
    # TODO:
    # remove this wrapper after activemerchant upgrade
    ActiveSupport::Deprecation.silence do
      @notification ||= Paypal::Notification.new(request.raw_post)
    end
  end

  def payment_id
    notitication.item_id
  end
end
