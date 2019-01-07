# frozen_string_literal: true

class Dto::Admin::DescreteCustomersRegistrations < Dto::Admin::DescreteBase
  private

  def values_by_days
    @result ||= User.in_days(@number_of_days).group('created_at::date').count
  end
end
