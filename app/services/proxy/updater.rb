class Proxy::Updater
  def self.update(fetcher_class)
    proxies = fetcher_class.fetch
    Proxy::Repository.persist proxies
  end
end
