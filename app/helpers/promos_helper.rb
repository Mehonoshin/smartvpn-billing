# frozen_string_literal: true

module PromosHelper
  def promo_types
    select_options(Promo::TYPES.map do |type|
      [t("activerecord.attributes.promo.types.#{type}"), type]
    end)
  end

  def promoter_types
    select_options(PromotersRepository.types.map do |type|
      [t("activerecord.attributes.promoter.types.#{type}"), type]
    end)
  end

  def select_options(options)
    { as: :select, collection: options, include_blank: false }
  end
end
