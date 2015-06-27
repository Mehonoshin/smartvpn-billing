class Admin::TrafficReportsController < Admin::BaseController
  def index
  end

  def users
  end

  def date
  end

  def servers
  end

  private

  def traffic_reports
    report.result
  end
  helper_method :traffic_reports

  def report
    "#{action_name.singularize.capitalize}TrafficReport".constantize.new(params[:traffic_report])
  end
  helper_method :report
end
