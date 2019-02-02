# frozen_string_literal: true

class DateTrafficReport < TrafficReport
  private

  def build_report
    # TODO:
    # It is grouped only by date, in one cell are grouped,
    # for example, all connections for September 15 and
    # also for October 15, November and etc.
    # group by unique date.
    Disconnect.group("DATE_TRUNC('day', created_at)")
              .select("
                DATE_TRUNC('day', created_at) AS date,
                SUM(traffic_in) AS traffic_in,
                SUM(traffic_out) AS traffic_out")
              .order('date DESC')
  end
end
