class UserDecorator < Draper::Decorator
  delegate_all

  def connection_status
    if model.connected?
      last_connect_details
    else
      h.t('admin.users.not_connected')
    end
  end

  def current_interval_payment_status
    if model.paid?
      h.human_date(model.withdrawals.last.created_at)
    else
      h.t('admin.users.not_paid')
    end
  end

  def options
    model.options.map(&:name)
  end

  def promotions
    model.promotions.map { |promotion| promotion.promo.name }
  end

  private

  def last_connect_details
    h.link_to h.admin_connection_path(model.last_connect) do
      h.t('admin.users.connected_to_server_at',
        server: model.last_connect.server.hostname,
        date: h.human_date(model.last_connect.created_at)
      )
    end
  end

end
