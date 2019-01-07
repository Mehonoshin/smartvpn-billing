# frozen_string_literal: true

module OptionsHelper
  # TODO:
  # refactor this helper to decorator

  def plans_option_price(plan, option_code)
    if !plan.option_prices.nil? && plan.option_prices.any?
      plan.option_prices[option_code].to_f
    end
  end

  def subscribe_option_button(option)
    option_button_to(option, billing_options_path(code: option.code), :post,
                     title: t('billing.options.activate'),
                     confirm: t('billing.options.confirms.activate'),
                     class: 'btn-success')
  end

  def unsubscribe_option_button(option)
    option_button_to(option, billing_option_path(option), :delete,
                     title: t('billing.options.deactivate'),
                     confirm: t('billing.options.confirms.deactivate'),
                     class: 'btn-danger')
  end

  def option_toggle_button(option)
    button_to toggle_state_title(option), toggle_billing_option_path(option), method: :put, class: 'btn primary'
  end

  def toggle_state_title(option)
    enabled_option?(option) ? t('billing.options.states.enable') : t('billing.options.states.disable')
  end

  def enabled_option?(option)
    current_user.user_options.find_by(option_id: option.id).try(:enabled?)
  end

  def option_attribute(name, attribute_hash, current_value)
    OptionAttributeDecorator.new(name, attribute_hash, current_value).render
  end

  def option_button_to(_option, url, method, options = {})
    form_tag url, method: method, html: { class: 'button_to' } do
      concat submit_tag(options[:title], class: "btn #{options[:class]}", data: { confirm: options[:confirm] })
    end
  end

  def option_settings(option)
    form_tag billing_option_path(option), method: :put, remote: true do
      option.tunable_attributes.each do |name, attribute|
        concat option_attribute("option_attributes[#{name}]", attribute, current_attribute_value(option, name))
      end
    end
  end

  def current_attribute_value(option, name)
    user_option = option.user_options.where(user_id: current_user.id).last
    user_option ? user_option.attrs[name.to_s] : nil
  end
end
