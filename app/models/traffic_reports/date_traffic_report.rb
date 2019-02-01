class DateTrafficReport < TrafficReport

  private

  def build_report
    # TODO:
    # Группируется только по дате,
    # получается что в одну ячейку сгруппируются допустим все подключения за 15 сентбяря
    # а также и за 15 октября, ноября и тп.
    # группировать по уникальной дате.
    Disconnect.group("DATE_TRUNC('day', created_at)")
              .select("
                DATE_TRUNC('day', created_at) AS date,
                SUM(traffic_in) AS traffic_in,
                SUM(traffic_out) AS traffic_out")
              .order("date DESC")
  end
end
