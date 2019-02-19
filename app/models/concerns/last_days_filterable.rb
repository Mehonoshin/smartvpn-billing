# frozen_string_literal: true

module LastDaysFilterable
  extend ActiveSupport::Concern

  included do
    def self.in_days(number_of_days)
      from_at = number_of_days.days.ago.to_time.beginning_of_day
      to_at = Date.current.tomorrow.to_time.end_of_day

      where(created_at: [from_at..to_at])
    end
  end
end
