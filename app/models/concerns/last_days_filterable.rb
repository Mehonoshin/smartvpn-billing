# frozen_string_literal: true

module LastDaysFilterable
  extend ActiveSupport::Concern

  included do
    scope :in_days, ->(number_of_days) { where('created_at BETWEEN ? AND ?', number_of_days.days.ago, Date.current.tomorrow) }
  end
end
