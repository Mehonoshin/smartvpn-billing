# frozen_string_literal: true

class PaySystemDecorator < Draper::Decorator
  delegate_all

  def title
    h.link_to model.name, h.admin_pay_system_path(model)
  end

  def human_state
    I18n.t("admin.pay_systems.states.#{pay_system.state}")
  end
end
