module PromosHelper
  def promo_types
    select_options(Promo::TYPES.map { |type|
      [t("activerecord.attributes.promo.types.#{type}"), type]
    })
  end

  def promoter_types
    select_options(PromotersRepository.types.map { |type|
      [t("activerecord.attributes.promoter.types.#{type}"), type]
    })
  end

  def select_options(options)
    { as: :select, collection: options, include_blank: false }
  end
end
