# frozen_string_literal: true

module ApplicationHelper
  def human_date(date, options = { time: true })
    format = options[:time] ? '%d.%m.%Y %H:%M' : '%d.%m.%Y'
    date&.strftime(format)
  end

  def human_price(price)
    human_usd_amount(price)
  end

  def human_usd_amount(price)
    "#{prettify_number(price)} USD"
  end

  def prettify_number(number)
    tokens = number.to_s.split('.')
    if tokens[1] == '0'
      tokens[0]
    else
      number&.round(2)
    end
  end
end
