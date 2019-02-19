# frozen_string_literal: true

class RefreshProxyListWorker
  include Sidekiq::Worker

  def perform
    adapter = Proxy::Fetchers::FreeProxyListNet::WebParser
    Proxy::Updater.update(adapter)
  end
end
