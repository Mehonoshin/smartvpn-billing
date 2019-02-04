# frozen_string_literal: true

class ServerTrafficReport < TrafficReport
  private

  def build_report
    Disconnect.group('server_id')
              .select('
                server_id,
                SUM(traffic_in) AS traffic_in,
                SUM(traffic_out) AS traffic_out')
              .order('server_id ASC')
  end
end
