# frozen_string_literal: true

namespace :smartvpn do
  namespace :proxy do
    desc 'Update proxy list'
    task update: :environment do
      adapter = Proxy::Fetchers::FreeProxyListNet::WebParser
      Proxy::Updater.update(adapter)
    end
  end
end
