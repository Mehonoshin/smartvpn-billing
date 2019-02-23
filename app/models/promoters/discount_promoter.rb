# frozen_string_literal: true

class DiscountPromoter < Promoter
  class << self
    def type
      'discount'
    end

    def apply(promo, base_value)
      # TODO:
      # сделать аналог attributable на серверисте
      # то есть декларативно делаем в промоутере attribute :percent, Integer
      # это определяет геттеры для него
      # и автоматическое приведение типа
      # геттеры уже проксируют в promo запрос
      percent = promo.attrs['discount_percent'].to_i
      base_value * (1 - (percent / 100.0))
    end

    def attributes
      [:discount_percent]
    end
  end
end
