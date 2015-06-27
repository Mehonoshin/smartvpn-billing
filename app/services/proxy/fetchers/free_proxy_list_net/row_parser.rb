module Proxy
  module Fetchers
    module FreeProxyListNet
      class RowParser
        def initialize(row)
          @row = row
        end

        def to_proxy
          ::Proxy::ProxyDto.new(host, port, country, protocol, bandwidth, ping)
        end

        private

        def host
          @row[0].text
        end

        def port
          @row[1].text
        end

        def country
          @row[3].text
        end

        def protocol
          @row[6].text == 'yes' ? 'https' : 'http'
        end

        def anonymity
          @row[4].text
        end

        def location
        end

        def bandwidth
        end

        def ping
        end
      end
    end
  end
end

