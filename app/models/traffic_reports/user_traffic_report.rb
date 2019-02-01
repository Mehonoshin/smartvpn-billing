class UserTrafficReport < TrafficReport

  private

  def build_report
    Disconnect.group('user_id')
              .select('
                user_id,
                SUM(traffic_in) AS traffic_in,
                SUM(traffic_out) AS traffic_out')
              .order('user_id ASC')
  end
end
