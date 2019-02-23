# frozen_string_literal: true

module Currencies
  class CourseConverter
    def initialize(options)
      @currency_from = options[:currency_from]
      @currency_to = options[:currency_to]
      @amount_in = options[:amount]
    end

    def convert_amount
      @amount_in * course.to_f
    end

    def course
      Course.new(@currency_from, @currency_to).get
    end
  end
end
