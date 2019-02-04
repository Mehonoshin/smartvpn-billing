# frozen_string_literal: true

class Promoter
  class << self
    def type
      raise 'Implement it in child class'
    end

    def apply(_promo, _base_value)
      raise 'Implement it in child class'
    end

    def attributes
      []
    end
  end
end
