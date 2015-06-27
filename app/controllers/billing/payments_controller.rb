class Billing::PaymentsController < Billing::BaseController
  def index
    @pay_systems = PaySystem.enabled
  end

  def new
    @pay_system = PaySystem.find_by_code(params[:code])
    @payment = Payment.new(amount: default_price, pay_system_id: @pay_system.id)
  end

  def create
    @payment = current_user.payments.create!(payment_params)
    redirect_to merchant_billing_payment_path(@payment)
  end

  def merchant
    @payment = current_user.payments.find(params[:id])
    redirect_to billing_payments_path if @payment.accepted?
  end

  private

  def default_price
    Currencies::CourseConverter
    .new(currency_from: 'usd', currency_to: @pay_system.currency, amount: current_user.plan.price)
    .convert_amount
    .round
  end

  def payment_params
    params.require(:payment).permit(:amount, :pay_system_id)
  end
end
