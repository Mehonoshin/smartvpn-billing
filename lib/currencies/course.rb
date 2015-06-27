require 'net/http'
require 'uri'

module Currencies
  class Course
    COURSES = [
      {from: 'eur', to: 'usd'},
      {from: 'rub', to: 'usd'}
    ]

    class << self
      def update_courses
        COURSES.each do |direction|
          course = fetch_course_from_web direction[:from], direction[:to]
          save_course(direction[:from], direction[:to], course)
        end
        persist_update_date
      end

      def fetch_course_from_web(from, to)
        bank = Money::Bank::RussianCentralBank.new
        bank.update_rates
        bank.get_rate from, to
      end

      def save_course(from, to, course)
        redis.set("smartvpn:#{from}_#{to}", course)
      end

      def persist_update_date
        redis.set("smartvpn:courses:updated_at", Time.current)
      end

      def updated_at
        redis.get('smartvpn:courses:updated_at')
      end

      def redis
        Redis.new
      end
    end

    def initialize(from_currency, to_currency)
      @from_currency = from_currency
      @to_currency = to_currency
    end

    def get
      if @from_currency == @to_currency
        1
      else
        fetch_from_redis || parse_from_web
      end
    end

    private

    def fetch_from_redis
      redis = Redis.new
      redis.get("smartvpn:#{@from_currency}_#{@to_currency}")
    end

    def parse_from_web
      Course.fetch_course_from_web @from_currency, @to_currency
    end
  end
end
