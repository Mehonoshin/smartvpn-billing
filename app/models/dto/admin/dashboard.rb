class Dto::Admin::Dashboard < Dto::Base
  DESCRETE_DAYS_NUMBER = 12
  attr_accessor :income, :customers, :traffic, :courses

  def initialize(attributes = {})
    super
    collect_data
  end

  private

  def collect_data
    @income, @customers, @traffic, @courses = {}, {}, {}, {}
    fetch_courses
    assign_total_statistics
    assign_discrete_total_statistics
  end

  def fetch_courses
    @courses[:rub_usd] = Currencies::Course.new("rub", "usd").get.to_f
    @courses[:eur_usd] = Currencies::Course.new("eur", "usd").get.to_f
    @courses[:updated_at] = Currencies::Course.updated_at.try(:to_datetime)
  end

  def assign_total_statistics
    @income[:total] = Payment.sum(:usd_amount)
    @customers[:total] = User.count
    @traffic[:total] = Disconnect.sum(:traffic_out)
  end

  def assign_discrete_total_statistics
    payments = Dto::Admin::DescretePayments.new(DESCRETE_DAYS_NUMBER)
    @income[:discrete] = payments.amounts.sort.map { |date| date[1].to_i }

    traffic = Dto::Admin::DescreteTraffic.new(DESCRETE_DAYS_NUMBER)
    @traffic[:discrete] = traffic.amounts.sort.map { |date| BytesConverter.prettify_float(BytesConverter.bytes_to_gigabytes(date[1])) }

    customers = Dto::Admin::DescreteCustomersRegistrations.new(DESCRETE_DAYS_NUMBER)
    @customers[:discrete] = customers.amounts.sort.map { |date| date[1] }
  end

end
