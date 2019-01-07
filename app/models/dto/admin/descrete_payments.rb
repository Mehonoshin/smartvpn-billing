# frozen_string_literal: true

class Dto::Admin::DescretePayments < Dto::Admin::DescreteBase
  private

  def values_by_days
    @result ||= Payment.in_days(@number_of_days).group('created_at::date').sum(:amount)
  end
end
