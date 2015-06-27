module MainHelper
  def was_connected?
    current_user.last_connect
  end

  def enabled_options
    current_user.promotions.with_active_promos.map { |promotion| promotion.promo.name }.join(",")
  end
end
