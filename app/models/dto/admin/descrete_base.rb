class Dto::Admin::DescreteBase < Dto::Base
  def initialize(number_of_days)
    @number_of_days = number_of_days
  end

  def amounts
    add_zero_amounts_for_dates_in_range
    values_by_days
  end

  private

  def add_zero_amounts_for_dates_in_range
    1.upto(@number_of_days) do |i|
      if values_by_days[(i.day.ago).to_date] == nil
        values_by_days[(i.day.ago).to_date] = 0
      end
    end
  end

  def values_by_days
    raise DtoException, "Implement in a subclass"
  end
end
