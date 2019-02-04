# frozen_string_literal: true

class PromotersRepository
  class << self
    def clean
      @index = nil
    end

    def all
      index.values
    end

    def types
      index.keys
    end

    def persist(promoter)
      index[promoter.type] = promoter
    end

    def find_by_type(type_name)
      index[type_name.to_s]
    end

    private

    def index
      @index ||= {
        'discount' => DiscountPromoter
      }
    end
  end
end
