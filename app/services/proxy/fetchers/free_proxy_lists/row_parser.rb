module Proxy
  module Fetchers
    module FreeProxyLists
      class RowParser
        def initialize(row)
          @row = row
        end

        def to_proxy
          ::Proxy::ProxyDto.new(host, port, country, protocol, bandwidth, ping)
        end

        private

        def host
          URI.unescape(
            @row[0].
            children[0].
            children[0].
            text.
            gsub!('IPDecode("', '').
            gsub!('")', '')
          )
        end

        def port
          @row[1].text
        end

        def country
          @row[4].text.strip
        end

        def protocol
          @row[2].text
        end

        def anonymity
          @row[3].text
        end

        def location
          @row[5].text
        end

        def bandwidth
          @row[8].children[0].children[0].attributes["style"].value.split('%')[0].split(':')[1]
        end

        def ping
          @row[9].children[0].children[0].attributes["style"].value.split('%')[0].split(':')[1]
        end
      end
    end
  end
end

