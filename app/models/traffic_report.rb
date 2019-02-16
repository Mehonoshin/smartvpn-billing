# frozen_string_literal: true

class TrafficReport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :result, :date_from, :date_to

  def initialize(attributes = {})
    attributes&.each do |name, value|
      send("#{name}=", value)
    end
  end

  def result
    @result = build_report.where(created_at: [date_from..date_to])
  end

  def date_from
    (@date_from.try(:to_time) || Time.current).beginning_of_month
  end

  def date_to
    (@date_to.try(:to_time) || Time.current).end_of_month
  end

  # To behave as active model
  def persisted?
    false
  end
end
