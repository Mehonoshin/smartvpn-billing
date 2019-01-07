# frozen_string_literal: true

class Dto::Admin::DescreteTraffic < Dto::Admin::DescreteBase
  private

  def values_by_days
    @result ||= Disconnect.in_days(@number_of_days).group('created_at::date').sum(:traffic_in)
  end
end
