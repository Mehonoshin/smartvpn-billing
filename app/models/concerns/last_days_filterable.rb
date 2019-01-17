module LastDaysFilterable
  extend ActiveSupport::Concern

  included do
    scope :in_days, ->(number_of_days) { where(created_at: [number_of_days.days.ago..Date.current.tomorrow]) }
  end
end
