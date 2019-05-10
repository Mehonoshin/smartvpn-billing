# frozen_string_literal: true

class Billing::OptionsController < Billing::BaseController
  def index
    @subscribed_user_options = current_user.user_options.order('id ASC').map(&:option)
    @unsubscribed_user_options = current_user.plan.options.order('id ASC') - @subscribed_user_options
  end

  def create
    if Option::Activator.run(current_user, params[:code])
      redirect_to billing_options_path, notice: t('billing.options.notices.activated')
    else
      redirect_to billing_options_path, alert: t('billing.options.notices.not_activated')
    end
  end

  def destroy
    Option::Deactivator.run(current_user, params[:id])
    redirect_to billing_options_path, notice: t('billing.options.notices.deactivated')
  end

  def update
    option = current_user.user_options.find_by(option_id: params[:id])
    option.update(attrs: params[:option_attributes])
    render body: nil
  end

  def toggle
    option = current_user.user_options.find_by(option_id: params[:id])
    option.toggle!
    redirect_to billing_options_path, notice: t('billing.options.notices.updated')
  end
end
