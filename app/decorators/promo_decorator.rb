# frozen_string_literal: true

class PromoDecorator < Draper::Decorator
  delegate_all

  def period
    "#{h.human_date(model.date_from, time: false)} - #{h.human_date(model.date_to, time: false)}"
  end

  def type
    I18n.t("activerecord.attributes.promo.types.#{model.type}")
  end

  def promoter_type
    I18n.t("activerecord.attributes.promoter.types.#{model.promoter_type}")
  end

  def state
    h.content_tag :span, class: state_class do
      I18n.t("activerecord.attributes.promo.states.#{model.state}")
    end
  end

  private

  def state_class
    model.active? ? 'green' : 'red'
  end
end
