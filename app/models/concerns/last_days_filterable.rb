module LastDaysFilterable
  extend ActiveSupport::Concern

  included do
    def self.in_days(number_of_days)
      where(created_at: [number_of_days.days.ago.to_time.beginning_of_day..Date.current.tomorrow.to_time.end_of_day])
    end
  end
end
