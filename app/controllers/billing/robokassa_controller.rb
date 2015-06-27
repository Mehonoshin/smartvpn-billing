class Billing::RobokassaController < Billing::MerchantController
  include ActiveMerchant::Billing::Integrations

  before_filter :create_notification

  def result
    if @notification.acknowledge
      render text: "Done"
      payment.accept!
    else
      raise "Invalid robokassa notification"
    end
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, secret: Settings.robokassa.secret2)
  end

  def payment_id
    params["InvId"]
  end

end
