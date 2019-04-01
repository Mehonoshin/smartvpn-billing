# frozen_string_literal: true

module LastDaysFilterable
  extend ActiveSupport::Concern

  included do
    def self.in_days(number_of_days)
      from_at = number_of_days.days.ago.beginning_of_day
      to_at = Time.current.tomorrow.end_of_day

      where(created_at: [from_at..to_at])
    end
  end
end
