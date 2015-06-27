module Proxy
  module Fetchers
    class Base
      def self.fetch
        fetcher = self.new
        fetcher.fetch_proxy_list
      end

      def fetch_proxy_list
        raise NotImplementedException, "Implement method in child class"
      end
    end
  end
end
