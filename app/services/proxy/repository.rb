module Proxy
  class Repository
    def self.persist(proxies)
      Proxy::Node.transaction do
        clear_nodes
        proxies.each do |proxy|
          build_node(proxy)
        end
      end
    end

    def self.build_node(proxy)
      unless Proxy::Node.create(proxy.to_hash)
        raise ActiveRecord::Rollback
      end
    end

    def self.clear_nodes
      Proxy::Node.delete_all
    end
  end
end
